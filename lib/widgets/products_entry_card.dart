import 'package:flutter/material.dart';
import 'package:kick_corner/models/products_entry.dart';

class ProductsEntryCard extends StatelessWidget {
  final ProductsEntry products;
  final VoidCallback onTap;

  const ProductsEntryCard({
    super.key,
    required this.products,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Cek apakah thumbnail ada dan tidak kosong
    final bool hasThumbnail =
        products.thumbnail != null && products.thumbnail!.isNotEmpty;

    // Tentukan widget thumbnail-nya
    Widget thumbnailWidget;
    if (hasThumbnail) {
      thumbnailWidget = ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          // ganti localhost -> 10.0.2.2 kalau pakai emulator Android
          'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(products.thumbnail!)}',
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 150,
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      );
    } else {
      thumbnailWidget = Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[300],
        ),
        child: const Center(
          child: Icon(Icons.image_not_supported),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                thumbnailWidget,
                const SizedBox(height: 8),

                // Nama produk
                Text(
                  products.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Category + Brand
                Text(
                  'Category: ${products.category} • Brand: ${products.brand}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 6),

                // Size & stock
                Text(
                  'Size: ${products.size} • Stock: ${products.stock}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),

                // Description (preview)
                Text(
                  products.description.length > 100
                      ? '${products.description.substring(0, 100)}...'
                      : products.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),

                // Harga + Featured badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp ${products.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (products.isFeatured)
                      const Chip(
                        label: Text(
                          'Featured',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.amber,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
