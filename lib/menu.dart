import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<ItemHomepage> items = [
    ItemHomepage(
      "All Products",
      Icons.storefront,
      const Color.fromARGB(255, 57, 119, 171),
    ),
    ItemHomepage(
      "My Products",
      Icons.inventory,
      const Color.fromARGB(255, 80, 139, 82),
    ),
    ItemHomepage(
      "Create Product",
      Icons.add_shopping_cart,
      const Color.fromARGB(255, 173, 74, 67),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar bagian atas halaman
      appBar: AppBar(
        title: const Text(
          'Kick Corner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Warna latar AppBar
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body halaman
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Selamat datang di Kick Corner!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24, // Atur ukuran font
                fontWeight: FontWeight.bold, // Tebalkan
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3, // 3 tombol dalam satu baris
              shrinkWrap: true,

              // Menampilkan ItemCard untuk setiap item dalam list
              children: items.map((ItemHomepage item) {
                return ItemCard(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}")),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
