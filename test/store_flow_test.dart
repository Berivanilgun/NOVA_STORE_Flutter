import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nova_store/main.dart';
import 'package:nova_store/screens/store.dart';

const captureScreenshots = bool.fromEnvironment('CAPTURE_SCREENSHOTS');

Future<void> capture(WidgetTester tester, String name) async {
  if (captureScreenshots) {
    await expectLater(
      find.byKey(const ValueKey('store-screenshot')),
      matchesGoldenFile('../docs/screenshots/$name.png'),
    );
  }
}

Future<void> openStore(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  // Asset I/O needs real async time; pumpAndSettle only advances test frames.
  // Preload the JSON before the FutureBuilder displays its animated spinner.
  await tester.runAsync(() async {
    await rootBundle.loadString('assets/products.json');
  });
  await tester.pumpWidget(const RepaintBoundary(
    key: ValueKey('store-screenshot'),
    child: NovaApp(),
  ));
  await tester.pumpAndSettle();
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(tester.takeException(), isNull);
}

void main() {
  setUpAll(() async {
    final loader = FontLoader('Roboto')
      ..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
    await loader.load();
  });
  testWidgets('Yerel ürün görselleri ve JSON yüklenir', (tester) async {
    await openStore(tester);
    final images = <String>{
      'headphones',
      'bag',
      'cup',
      'watch',
      'lamp',
      'shoe',
      'shirt',
      'bottle',
    };
    for (final image in images) {
      final bytes = await rootBundle.load('assets/images/$image.png');
      expect(bytes.lengthInBytes, greaterThan(0));
    }
    expect(find.text('NOVA STORE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Ana sayfa, katalog, detay ve sepet akışı', (tester) async {
    await openStore(tester);
    await capture(tester, 'home');
    await tester.tap(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    expect(find.byType(CatalogPage), findsOneWidget);
    expect(find.text('8 ürün'), findsOneWidget);
    await capture(tester, 'catalog');

    await tester.tap(find.widgetWithText(ChoiceChip, 'Elektronik'));
    await tester.pumpAndSettle();
    expect(find.text('2 ürün'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'kulaklık');
    await tester.pumpAndSettle();
    expect(find.text('1 ürün'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'bulunmayan ürün');
    await tester.pumpAndSettle();
    expect(find.text('Aramana uygun ürün bulunamadı.'), findsOneWidget);
    await tester.tap(find.byTooltip('Aramayı temizle'));
    await tester.pumpAndSettle();
    expect(find.text('2 ürün'), findsOneWidget);

    await tester.tap(find.text('Studio Kulaklık'));
    await tester.pumpAndSettle();
    expect(find.byType(DetailPage), findsOneWidget);
    expect(find.text('1499,00 TL'), findsOneWidget);
    await capture(tester, 'detail');
    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sepet (1)'));
    await tester.pumpAndSettle();
    expect(find.byType(CartPage), findsOneWidget);
    expect(find.text('Toplam: 1499,00 TL'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await capture(tester, 'cart');

    await tester.tap(find.byTooltip('Adedi artır'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam: 2998,00 TL'), findsOneWidget);
    await tester.tap(find.byTooltip('Adedi azalt'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam: 1499,00 TL'), findsOneWidget);
    await tester.tap(find.text('Sepeti temizle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vazgeç'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam: 1499,00 TL'), findsOneWidget);
    await tester.tap(find.text('Sepeti temizle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Temizle'));
    await tester.pumpAndSettle();
    expect(find.text('Sepetin henüz boş.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
