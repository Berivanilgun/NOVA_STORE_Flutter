import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nova_store/main.dart';
import 'package:nova_store/screens/store.dart';

const captureScreenshots = bool.fromEnvironment('CAPTURE_SCREENSHOTS');

Future<void> capture(WidgetTester tester, String name) async {
  if (captureScreenshots) {
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
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
  // Complete asset I/O in real async time before settling animated frames.
  await tester.runAsync(() async {
    await tester.pumpWidget(const RepaintBoundary(
      key: ValueKey('store-screenshot'),
      child: NovaApp(),
    ));
    await tester.pump();
    final context = tester.element(find.byType(NovaApp));
    for (final name in [
      'headphones',
      'bag',
      'cup',
      'watch',
      'lamp',
      'shoe',
      'shirt',
      'bottle',
    ]) {
      await precacheImage(AssetImage('assets/images/$name.png'), context);
    }
  });
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
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
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

  testWidgets('Büyük metinde ortak sepet, demo ve yeniden başlatma',
      (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await openStore(tester);
    await tester.tap(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byTooltip('Sepete ekle').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Studio Kulaklık'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sepete ekle'));
    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sepet (2)'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam: 2998,00 TL'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Sepeti incele'));
    await tester.pumpAndSettle();
    expect(find.text('Demo sepet'), findsOneWidget);
    expect(find.textContaining('ödeme alınmaz'), findsOneWidget);
    await tester.tap(find.text('Tamam'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Adedi azalt'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Adedi azalt'));
    await tester.pumpAndSettle();
    expect(find.text('Sepetin henüz boş.'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sepete ekle'));
    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    expect(find.text('Sepet (1)'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await openStore(tester);
    expect(find.text('Sepet (0)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
