// import 'package:flutter/material.dart';
// import 'package:kick_corner/screens/menu.dart';
// import 'package:kick_corner/screens/productslist_form.dart';
// import 'package:kick_corner/screens/products_entry_list.dart';

// class ItemCard extends StatelessWidget {
//   // Menampilkan kartu dengan ikon dan nama.

//   final ItemHomepage item;

//   const ItemCard(this.item, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       // Menentukan warna latar belakang dari tema aplikasi.
//       color: item.color,
//       // Membuat sudut kartu melengkung.
//       borderRadius: BorderRadius.circular(12),

//       child: InkWell(
//         // Aksi ketika kartu ditekan.
//         onTap: () async {
//           // Menampilkan pesan SnackBar saat kartu ditekan.
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(
//               SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
//             );

//           // Navigate ke route yang sesuai (tergantung jenis tombol)
//           if (item.name == "Create Product") {
//             // Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ProductsFormPage.
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const ProductsFormPage()),
//             );
//           }
//           else if (item.name == "All Products") {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const ProductsEntryListPage()
//               ),
//             );
//           }
//         },
//         // Container untuk menyimpan Icon dan Text
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           child: Center(
//             child: Column(
//               // Menyusun ikon dan teks di tengah kartu.
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   item.icon,
//                   color: Colors.white,
//                   size: 30.0,
//                 ),
//                 const Padding(padding: EdgeInsets.all(3)),
//                 Text(
//                   item.name,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }