import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kick_corner/models/products_entry.dart';
import 'package:kick_corner/screens/menu.dart';
import 'package:kick_corner/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductsFormPage extends StatefulWidget {
  final ProductsEntry? product;
  final bool isEdit;

  const ProductsFormPage({super.key, this.product, this.isEdit = false});

  @override
  State<ProductsFormPage> createState() => _ProductsFormPageState();
}

class _ProductsFormPageState extends State<ProductsFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int? _price;
  String _description = "";
  String _thumbnail = "";
  String _category = "jersey";
  bool _isFeatured = false;
  int _stock = 1;
  String _brand = "";
  String _size = ""; // size bebas (string)

  final List<String> _categories = const [
    'jersey',
    'shoes',
    'ball',
    'accessory',
    'training',
    'nutrition',
    'merchandise',
  ];

  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();

    final p = widget.product;
    if (widget.isEdit && p != null) {
      // isi awal dari produk yang mau diedit
      _name = p.name;
      _price = p.price;
      _description = p.description;
      _thumbnail = p.thumbnail ?? "";
      _category = p.category;
      _isFeatured = p.isFeatured;
      _stock = p.stock;
      _brand = p.brand;
      _size = p.size.toString();
      _stockController = TextEditingController(text: _stock.toString());
    } else {
      // mode tambah
      _stockController = TextEditingController(text: '1');
    }
  }

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _submit(CookieRequest request) async {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "name": _name,
      "price": _price,
      "description": _description,
      "thumbnail": _thumbnail,
      "category": _category,
      "is_featured": _isFeatured,
      "stock": _stock,
      "brand": _brand,
      "size": _size, // string
    };

    final String url;
    if (widget.isEdit && widget.product != null) {
      url =
          "http://localhost:8000/products/edit-flutter/${widget.product!.id}/";
    } else {
      url = "http://localhost:8000/products/create-flutter/";
    }

    final response = await request.postJson(url, jsonEncode(payload));

    if (!mounted) return;

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEdit
                ? "Produk berhasil diperbarui."
                : "Produk berhasil ditambahkan.",
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['message'] ?? "Terjadi kesalahan, silakan coba lagi.",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.isEdit ? 'Edit Produk' : 'Form Tambah Produk'),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Harga
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _price != null ? _price.toString() : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Isi Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    _price = int.tryParse(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    final parsed = int.tryParse(value);
                    if (parsed == null) {
                      return "Harga harus berupa angka!";
                    }
                    if (parsed <= 0) {
                      return "Harga harus lebih dari 0!";
                    }
                    return null;
                  },
                ),
              ),

              // Deskripsi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _description,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Isi Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Thumbnail
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _thumbnail,
                  decoration: InputDecoration(
                    hintText: "Isi Link URL untuk Thumbnail",
                    labelText: "Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _thumbnail = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Thumbnail tidak boleh kosong!";
                    }
                    final uri = Uri.tryParse(value);
                    if (uri == null ||
                        uri.scheme.isEmpty ||
                        !(uri.scheme == 'http' || uri.scheme == 'https')) {
                      return "Masukkan URL yang valid (http/https)!";
                    }
                    return null;
                  },
                ),
              ),

              // Kategori
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _category = newValue;
                      });
                    }
                  },
                ),
              ),

              // Is Featured
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // Stok
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Isi Jumlah Stok",
                    labelText: "Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            final current =
                                int.tryParse(_stockController.text) ?? 1;
                            if (current > 1) {
                              final newVal = current - 1;
                              setState(() {
                                _stock = newVal;
                                _stockController.text = newVal.toString();
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final current =
                                int.tryParse(_stockController.text) ?? 0;
                            final newVal = current + 1;
                            setState(() {
                              _stock = newVal;
                              _stockController.text = newVal.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  onChanged: (value) {
                    _stock = int.tryParse(value) ?? 0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Stok tidak boleh kosong!";
                    }
                    final parsed = int.tryParse(value);
                    if (parsed == null) {
                      return "Stok harus berupa angka!";
                    }
                    if (parsed <= 0) {
                      return "Stok minimal 1!";
                    }
                    return null;
                  },
                ),
              ),

              // Brand
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _brand,
                  decoration: InputDecoration(
                    hintText: "Isi Nama Brand",
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _brand = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Brand tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Size (string)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _size,
                  decoration: InputDecoration(
                    hintText: "Isi Ukuran Produk (misal: 40 atau M/L)",
                    labelText: "Ukuran",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _size = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ukuran tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // Tombol submit
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _submit(request),
                    child: Text(
                      widget.isEdit ? "Simpan Perubahan" : "Submit",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
