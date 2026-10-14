import 'package:flutter/foundation.dart';
import '../models/product.dart';

class Cart extends ChangeNotifier {
  final Map<int, int> _quantities = {};
  final Map<int, Product> _products = {};
  List<Product> get products => List.unmodifiable(_products.values);
  int quantity(Product p) => _quantities[p.id] ?? 0;
  int get count => _quantities.values.fold(0, (a, b) => a + b);
  int get total =>
      _products.values.fold(0, (a, p) => a + p.priceKurus * quantity(p));
  void add(Product p) {
    _products[p.id] = p;
    _quantities[p.id] = quantity(p) + 1;
    notifyListeners();
  }

  void remove(Product p) {
    final q = quantity(p);
    if (q <= 1) {
      _quantities.remove(p.id);
      _products.remove(p.id);
    } else {
      _quantities[p.id] = q - 1;
    }
    notifyListeners();
  }

  void clear() {
    _quantities.clear();
    _products.clear();
    notifyListeners();
  }
}
