import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/cart.dart';

class CartButton extends StatelessWidget {
  final Cart cart;
  const CartButton({super.key, required this.cart});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
      listenable: cart,
      builder: (_, __) => TextButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute<void>(builder: (_) => CartPage(cart: cart))),
          icon: const Icon(Icons.shopping_bag_outlined),
          label: Text('Sepet (${cart.count})')));
}

class HomePage extends StatelessWidget {
  final List<Product> products;
  final Cart cart;
  const HomePage({super.key, required this.products, required this.cart});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Text('NOVA STORE',
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2)),
          actions: [CartButton(cart: cart)]),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Az eşya, çok stil.',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Günlük hayatına eşlik edecek favorilerini keşfet.'),
        const SizedBox(height: 24),
        Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: const Color(0xffe6dcfc),
                borderRadius: BorderRadius.circular(24)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: 112,
                  child: Row(children: [
                    Expanded(
                        child: Image.asset('assets/images/headphones.png',
                            fit: BoxFit.contain,
                            semanticLabel: 'Studio Kulaklık')),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Image.asset('assets/images/bag.png',
                            fit: BoxFit.contain,
                            semanticLabel: 'Daypack Çanta')),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Image.asset('assets/images/shoe.png',
                            fit: BoxFit.contain,
                            semanticLabel: 'Urban Sneaker')),
                  ])),
              const SizedBox(height: 16),
              const Text('Yeni sezon seçkisi',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                      'Elektronikten yaşam ürünlerine, sana göre bir keşif.')),
              FilledButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (_) =>
                              CatalogPage(products: products, cart: cart))),
                  child: const Text('Kataloğu keşfet')),
            ])),
        const SizedBox(height: 28),
        const Text('Öne çıkanlar',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...products.take(3).map((p) => Card(
            child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(p.image, width: 72, fit: BoxFit.cover)),
                title: Text(p.name),
                subtitle: Text(money(p.priceKurus)),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () =>
                    Navigator.pushNamed(context, '/detail', arguments: p)))),
        const SizedBox(height: 20),
        const Text('Eğitim projesi • Gerçek satış veya ödeme yapılmaz.',
            textAlign: TextAlign.center),
      ]));
}

String normalize(String value) =>
    value.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();

class CatalogPage extends StatefulWidget {
  final List<Product> products;
  final Cart cart;
  const CatalogPage({super.key, required this.products, required this.cart});
  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String query = '', category = 'Tümü';
  final search = TextEditingController();
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Tümü',
      ...widget.products.map((p) => p.category).toSet()
    ];
    final filtered = widget.products
        .where((p) =>
            (category == 'Tümü' || p.category == category) &&
            normalize('${p.name} ${p.category}')
                .contains(normalize(query.trim())))
        .toList();
    return Scaffold(
        appBar: AppBar(
            title: const Text('Katalog'),
            actions: [CartButton(cart: widget.cart)]),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: TextField(
                  controller: search,
                  onChanged: (v) => setState(() => query = v),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Ürün veya kategori ara',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)),
                      suffixIcon: IconButton(
                          tooltip: 'Aramayı temizle',
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            search.clear();
                            setState(() => query = '');
                          })))),
          SizedBox(
              height: 54,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => ChoiceChip(
                      label: Text(categories[i]),
                      selected: category == categories[i],
                      onSelected: (_) =>
                          setState(() => category = categories[i])))),
          Padding(
              padding: const EdgeInsets.all(12),
              child: Text('${filtered.length} ürün')),
          Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('Aramana uygun ürün bulunamadı.'))
                  : LayoutBuilder(
                      builder: (_, constraints) => GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          itemCount: filtered.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: constraints.maxWidth >= 900
                                      ? 4
                                      : constraints.maxWidth >= 600
                                          ? 3
                                          : 2,
                                  mainAxisExtent: 300,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12),
                          itemBuilder: (_, i) => ProductCard(
                              product: filtered[i], cart: widget.cart)))),
        ]));
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final Cart cart;
  const ProductCard({super.key, required this.product, required this.cart});
  @override
  Widget build(BuildContext context) => Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, '/detail', arguments: product),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: Hero(
                    tag: product.id,
                    child: Image.asset(product.image, fit: BoxFit.cover))),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Text(product.category,
                    style: const TextStyle(fontSize: 12))),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 4, 4),
                child: Row(children: [
                  Expanded(child: Text(money(product.priceKurus))),
                  IconButton(
                      tooltip: 'Sepete ekle',
                      onPressed: () => addToCart(context, cart, product),
                      icon: const Icon(Icons.add_shopping_cart))
                ])),
          ])));
}

void addToCart(BuildContext context, Cart cart, Product p) {
  cart.add(p);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        content: Text('${p.name} sepete eklendi.'),
        duration: const Duration(seconds: 2)));
}

class DetailPage extends StatelessWidget {
  final Product product;
  final Cart cart;
  const DetailPage({super.key, required this.product, required this.cart});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Text('Ürün detayı'), actions: [CartButton(cart: cart)]),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Hero(
                tag: product.id,
                child: Image.asset(product.image,
                    height: 300, fit: BoxFit.contain))),
        const SizedBox(height: 24),
        Text(product.category,
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 8),
        Text(product.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(money(product.priceKurus), style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        Text(product.description,
            style: const TextStyle(fontSize: 16, height: 1.6)),
        const SizedBox(height: 28),
        FilledButton.icon(
            onPressed: () => addToCart(context, cart, product),
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Padding(
                padding: EdgeInsets.all(14), child: Text('Sepete ekle'))),
      ]));
}

class CartPage extends StatelessWidget {
  final Cart cart;
  const CartPage({super.key, required this.cart});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: ListenableBuilder(
          listenable: cart,
          builder: (_, __) {
            if (cart.count == 0) {
              return const Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.shopping_bag_outlined, size: 64),
                SizedBox(height: 16),
                Text('Sepetin henüz boş.'),
                Text('Katalogdan ürün ekleyerek başlayabilirsin.')
              ]));
            }
            return Column(children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (_, i) {
                        final p = cart.products[i];
                        return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(children: [
                                  Row(children: [
                                    Image.asset(p.image, width: 64, height: 64),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Text(p.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Text(money(p.priceKurus * cart.quantity(p)))
                                  ]),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            tooltip: 'Adedi azalt',
                                            onPressed: () => cart.remove(p),
                                            icon: const Icon(
                                                Icons.remove_circle_outline)),
                                        Text('${cart.quantity(p)}'),
                                        IconButton(
                                            tooltip: 'Adedi artır',
                                            onPressed: () => cart.add(p),
                                            icon: const Icon(
                                                Icons.add_circle_outline))
                                      ]),
                                ])));
                      })),
              SafeArea(
                  top: false,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Toplam: ${money(cart.total)}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            FilledButton(
                                onPressed: () => showDialog<void>(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                            title: const Text('Demo sepet'),
                                            content: const Text(
                                                'Bu uygulama bir katalog simülasyonudur. Sipariş oluşturulmaz ve ödeme alınmaz.'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          dialogContext),
                                                  child: const Text('Tamam'))
                                            ])),
                                child: const Text('Sepeti incele')),
                            TextButton(
                                onPressed: () async {
                                  final clear = await showDialog<bool>(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                              title: const Text(
                                                  'Sepet temizlensin mi?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            dialogContext,
                                                            false),
                                                    child:
                                                        const Text('Vazgeç')),
                                                FilledButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            dialogContext,
                                                            true),
                                                    child:
                                                        const Text('Temizle'))
                                              ]));
                                  if (clear == true) {
                                    cart.clear();
                                  }
                                },
                                child: const Text('Sepeti temizle')),
                          ]))),
            ]);
          }));
}
