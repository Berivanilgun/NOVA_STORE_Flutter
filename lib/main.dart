import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/product.dart';
import 'data/cart.dart';
import 'screens/store.dart';

void main() => runApp(const NovaApp());

class NovaApp extends StatefulWidget {
  const NovaApp({super.key});
  @override
  State<NovaApp> createState() => _NovaAppState();
}

class _NovaAppState extends State<NovaApp> {
  final cart = Cart();
  late Future<List<Product>> products;
  Future<List<Product>> load() async {
    final data =
        jsonDecode(await rootBundle.loadString('assets/products.json')) as List;
    return data
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    products = load();
  }

  @override
  void dispose() {
    cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'NOVA STORE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0xfff8f7fb),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6551a5)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xfff8f7fb), centerTitle: false)),
      onGenerateRoute: (settings) {
        if (settings.name == '/detail' && settings.arguments is Product) {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (_) => DetailPage(
                  product: settings.arguments! as Product, cart: cart));
        }
        return null;
      },
      home: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                  body: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Ürünler yüklenemedi.'),
                TextButton(
                    onPressed: () => setState(() {
                          products = load();
                        }),
                    child: const Text('Tekrar dene'))
              ])));
            }
            if (!snapshot.hasData) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            return HomePage(products: snapshot.data!, cart: cart);
          }));
}
