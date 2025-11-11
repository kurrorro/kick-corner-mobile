import 'package:flutter/material.dart';
import 'package:kick_corner/widgets/left_drawer.dart';
import 'package:flutter/services.dart';

class ProductsFormPage extends StatefulWidget {
  const ProductsFormPage({super.key});

  @override
  State<ProductsFormPage> createState() => _ProductsFormPageState();
}

class _ProductsFormPageState extends State<ProductsFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int? _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "jersey";
  bool _isFeatured = false; // default
  int _stock = 1;
  String _brand = "";
  String _size = "";

  final List<String> _categories = [
    'jersey',
    'shoes',
    'ball',
    'accessory',
    'training',
    'nutrition',
    'merchandise',
  ];

  final TextEditingController _stockController = TextEditingController(
    text: '1',
  );

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Produk')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // drawer yang sudah dibuat
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Price ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // hanya digit
                  ],
                  decoration: InputDecoration(
                    hintText: "Isi Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.tryParse(value ?? "");
                    });
                  },
                  validator: (String? value) {
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

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Isi Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Thumbnail URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Isi Link URL untuk Thumbnail",
                    labelText: "Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
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

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              // === Stock ===
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
                  onChanged: (String? value) {
                    setState(() {
                      _stock = int.tryParse(value ?? "") ?? 0;
                    });
                  },
                  validator: (String? value) {
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

              // === Brand ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Isi Nama Brand",
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _brand = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Brand tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Size ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Isi Ukuran Produk",
                    labelText: "Ukuran",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _size = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Ukuran tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Submit ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama: $_name'),
                                    Text('Harga: $_price'),
                                    Text('Deskripsi: $_description'),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text('Kategori: $_category'),
                                    Text(
                                      'Unggulan: ${_isFeatured ? "Ya" : "Tidak"}',
                                    ),
                                    Text('Stok: $_stock'),
                                    Text('Brand: $_brand'),
                                    Text('Ukuran: $_size'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
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
