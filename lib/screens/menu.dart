import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kick_corner/models/products_entry.dart';
import 'package:kick_corner/screens/products_detail.dart';
import 'package:kick_corner/screens/productslist_form.dart';
import 'package:kick_corner/widgets/left_drawer.dart';
import 'package:kick_corner/widgets/products_entry_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

enum ProductFilter { all, my, featured }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductFilter _activeFilter = ProductFilter.all;

  Future<List<ProductsEntry>> _fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');
    final List<ProductsEntry> list = [];
    for (final d in response) {
      if (d != null) {
        list.add(ProductsEntry.fromJson(d));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final currentUserId = request.jsonData['id'];

    return Scaffold(
      appBar: AppBar(title: const Text('Kick Corner')),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kick Corner',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text(
              'Fuel Your Football Fever!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // filter + add product
            Row(
              children: [
                _buildFilterButton('All Product', ProductFilter.all),
                const SizedBox(width: 8),
                _buildFilterButton('My Product', ProductFilter.my),
                const SizedBox(width: 8),
                _buildFilterButton('Featured', ProductFilter.featured),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductsFormPage(),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: FutureBuilder<List<ProductsEntry>>(
                future: _fetchProducts(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Failed to load products.'),
                    );
                  }

                  final allProducts = snapshot.data ?? [];

                  final filtered = allProducts.where((p) {
                    switch (_activeFilter) {
                      case ProductFilter.all:
                        return true;
                      case ProductFilter.my:
                        if (currentUserId == null) return false;
                        return p.userId.toString() == currentUserId.toString();
                      case ProductFilter.featured:
                        return p.isFeatured;
                    }
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text('No product found :O'));
                  }

                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      final isOwner =
                          currentUserId != null &&
                          product.userId.toString() == currentUserId.toString();

                      return ProductsEntryCard(
                        products: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                        canModify: isOwner,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductsFormPage(
                                product: product,
                                isEdit: true,
                              ),
                            ),
                          ).then((_) => setState(() {}));
                        },
                        onDelete: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Hapus produk'),
                              content: const Text(
                                'Yakin ingin menghapus produk ini?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text(
                                    'Hapus',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm != true) return;

                          final resp = await request.postJson(
                            'http://localhost:8000/products/delete-flutter/${product.id}/',
                            jsonEncode({}),
                          );

                          if (!context.mounted) return;

                          if (resp['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Produk berhasil dihapus.'),
                              ),
                            );
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  resp['message'] ?? 'Gagal menghapus produk.',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, ProductFilter value) {
    final isActive = _activeFilter == value;
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _activeFilter = value;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isActive ? const Color(0xFF111827) : Colors.white,
          foregroundColor: isActive ? Colors.white : const Color(0xFF111827),
          side: BorderSide(
            color: isActive ? const Color(0xFF111827) : Colors.grey.shade300,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}

class ItemHomePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ItemHomePage({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
