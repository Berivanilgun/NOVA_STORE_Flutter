import 'package:flutter_test/flutter_test.dart';
import 'package:nova_store/data/cart.dart';
import 'package:nova_store/models/product.dart';

void main() {
  const p = Product(
      id: 1,
      name: 'Kupa',
      category: 'Yaşam',
      priceKurus: 24900,
      description: '',
      image: '');
  test('Sepet adet, toplam ve son ürünü kaldırma', () {
    final cart = Cart();
    cart.add(p);
    cart.add(p);
    expect(cart.count, 2);
    expect(cart.total, 49800);
    cart.remove(p);
    expect(cart.total, 24900);
    cart.remove(p);
    expect(cart.products, isEmpty);
    expect(cart.total, 0);
    cart.remove(p);
    expect(cart.count, 0);
    cart.dispose();
  });
  test('Model JSON dönüşümü kayıpsız', () {
    expect(Product.fromJson(p.toJson()).toJson(), p.toJson());
    expect(money(24900), '249,00 TL');
  });
}
