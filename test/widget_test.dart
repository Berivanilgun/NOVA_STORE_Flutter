import 'package:flutter_test/flutter_test.dart';
import 'package:nova_store/main.dart';

void main() {
  testWidgets('Ana sayfa ürünlerle açılır', (tester) async {
    await tester.pumpWidget(const NovaApp());
    await tester.pumpAndSettle();

    expect(find.text('NOVA STORE'), findsOneWidget);
    expect(find.text('Studio Kulaklık'), findsOneWidget);
    expect(find.text('Kataloğu keşfet'), findsOneWidget);
  });
}
