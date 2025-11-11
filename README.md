# Kick Corner

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

<details>
<summary><strong>Tugas Individu 7</strong></summary>

## Widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget

Di Flutter, semua yang terlihat di layar adalah widget. Antarmuka pengguna (UI) tersusun dari kumpulan widget dalam sebuah struktur pohon (*tree*) yang hirarkis.

- **Widget Tree**: Ini adalah cara Flutter merepresentasikan UI. Ada satu *root* widget (widget akar), yang memiliki *children* (anak), dan anak-anak itu bisa memiliki anak-anaknya sendiri, membentuk sebuah pohon.

- **Parent-Child (Induk-Anak)**:
    - **Parent (Induk)**: Adalah widget yang "mengandung" atau "membungkus" widget lain.
    - **Child (Anak)**: Adalah widget yang "dikandung" oleh widget lain.

Hubungan parent-child ini adalah fondasi dari cara kerja Flutter. Struktur ini memiliki dua tujuan utama:

- **Layout (Tata Letak)**: Parent bertanggung jawab mengatur posisi dan ukuran child-nya. Contoh: `Column` (parent) memerintahkan semua children-nya untuk berbaris secara vertikal.

- **Konteks (Data & Tema)**: Parent dapat "mewariskan" data atau informasi (seperti tema warna) ke semua children di bawahnya. Contoh: `MaterialApp` (parent) mewariskan tema indigo sehingga `AppBar` (child) tahu harus berwarna apa.

## Widget yang digunakan dalam proyek ini

| Widget | Deskripsi |
| --- | --- |
| `MaterialApp` | Widget akar (root) yang membungkus seluruh aplikasi dan menyediakan fungsionalitas dasar (tema, navigasi). |
| `StatelessWidget` | Tipe dasar untuk widget yang tidak mengelola state internal (contoh: `MyHomePage`, `ItemCard`). |
| `Scaffold` | Kerangka visual halaman, menyediakan `AppBar` (bilah atas) dan `body` (konten). |
| `AppBar` | Bilah judul aplikasi. |
| `Column` | Menyusun widget-widget anaknya secara vertikal. |
| `Padding` | Memberi ruang kosong (jarak) di sekitar widget anaknya. |
| `Text` | Menampilkan teks. |
| `SizedBox` | Membuat kotak dengan ukuran tertentu, sering digunakan untuk memberi spasi. |
| `GridView.count` | Menampilkan widget anaknya dalam format grid dengan jumlah kolom yang tetap. |
| `Material` & `InkWell` | Digunakan bersamaan di `ItemCard` untuk membuat area yang dapat diklik (`onTap`), memiliki warna, dan menampilkan efek riak. |
| `Icon` | Menampilkan ikon. |
| `ScaffoldMessenger` & `SnackBar` | Digunakan untuk menampilkan notifikasi pop-up dari bawah layar. |

## Fungsi widget MaterialApp? Mengapa widget ini sering digunakan sebagai widget root?

`MaterialApp` adalah widget inti yang membungkus seluruh aplikasi Flutter. Widget ini menyediakan fungsionalitas dasar yang diperlukan untuk membangun aplikasi yang bisa berfungsi dan terlihat konsisten.

Fungsionalitas ini adalah inti dari Material Design:
- **Tema (theme)**: Mendefinisikan ThemeData global (skema warna, font) yang akan diwariskan ke semua widget di bawahnya.
- **Navigasi (routes)**: Mengelola tumpukan halaman dan transisi antar layar.
- **Halaman Utama (home)**: Menentukan widget yang pertama kali ditampilkan saat aplikasi dimuat.

`MaterialApp` sering menjadi widget root karena widget-widget Material Design lainnya (seperti `Scaffold`, `Navigator`, `Theme`) bergantung padanya untuk mendapatkan data tema dan instruksi navigasi.

## Perbedaan antara StatelessWidget dan StatefulWidget. Kapan memilih salah satunya?

**`StatelessWidget` (Widget Statis)**
- **Definisi**: Widget yang *immutable* (tetap). Tampilannya tidak dapat berubah secara internal setelah dibuat.

- **Kapan berubah?** Tampilannya hanya diperbarui ketika data yang diterimanya dari *parent*-nya berubah, yang memicu *rebuild* dari luar.

- **Kapan digunakan?** Untuk UI yang statis atau hanya bergantung pada data dari *parent*-nya. Contoh: `Icon`, `Text`, dan `ItemCard` di proyek ini.

**`StatefulWidget` (Widget Dinamis)**
- **Definisi**: Widget yang *mutable* (dapat berubah). Memiliki objek State internal untuk menyimpan data yang bisa berubah seiring waktu.

- **Kapan berubah?** Tampilannya diperbarui ketika developer memanggil fungsi `setState()`. Ini memberi tahu Flutter untuk *rebuild* widget tersebut dengan data State yang baru.

- **Kapan digunakan?** Saat UI perlu berubah secara dinamis berdasarkan interaksi pengguna atau data internal. Contoh: `Checkbox` (mengingat status dicentang) atau `Text Field` (mengingat teks yang diketik).

## Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

`BuildContext` adalah "alamat" unik yang dimiliki setiap widget, yang mendeskripsikan lokasi widget tersebut di dalam Widget Tree.

**Fungsi Utamanya**: `BuildContext` digunakan untuk berinteraksi dengan widget lain di dalam pohon. Karena ia tahu lokasinya, ia bisa "mencari ke atas" pohon untuk menemukan *ancestor* (leluhur) terdekat.

**Contoh Penggunaan**: Ia adalah parameter context yang ada di setiap build method.

- `Theme.of(context)`: Menemukan data tema terdekat.

- `Navigator.of(context)`: Menemukan pengelola navigasi untuk pindah halaman.

- `ScaffoldMessenger.of(context)`: Menemukan `Scaffold` terdekat untuk menampilkan SnackBar (seperti yang kita lakukan di `ItemCard`).

## Konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart"

**Hot Reload**
- Menyuntikkan kode baru ke dalam Dart Virtual Machine (VM) yang sedang berjalan dan membangun ulang (*rebuild*) Widget Tree.

- Hasil: Perubahan UI terlihat instan (seringkali < 1 detik).

- State: State aplikasi tetap terjaga. (Contoh: Teks yang sedang diketik di formulir tidak akan hilang).

**Hot Restart**
- Menghancurkan Dart VM yang lama dan memulai ulang seluruh aplikasi dari awal.

- Hasil: Aplikasi dimulai ulang dari halaman utamanya.

- State: State aplikasi hilang (*restart*). Ini diperlukan saat mengubah sesuatu yang fundamental, seperti `initState()` atau variabel global.
</details>

<details>
<summary><strong>Tugas Individu 8</strong></summary>

## Perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter dan dalam kasus apa sebaiknya masing-masing digunakan?

`Navigator.push()`: Menambah halaman baru di atas stack, halaman lama masih ada. Kalau tekan tombol back, akan balik ke halaman sebelumnya. **Sebaiknya digunakan** ketika alur aplikasi mengharapkan pengguna bisa kembali ke halaman sebelumnya dengan menekan tombol "kembali".

`Navigator.pushReplacement()`: Mengganti halaman sekarang dengan halaman baru. Halaman lama dihapus dari stack, jadi tidak bisa balik lagi ke halaman sebelumnya dengan tombol *back*. **Sebaiknya digunakan** ketika alur aplikasi tidak mengizinkan pengguna untuk kembali ke halaman sebelumnya.

**Perbedaan** kedua method tersebut terletak pada apa yang dilakukan kepada *route* yang berada pada atas stack. `push()` akan menambahkan *route* baru diatas *route* yang sudah ada pada atas stack, sedangkan `pushReplacement() `menggantikan *route* yang sudah ada pada atas stack dengan *route* baru tersebut.

Pada aplikasi ini, `Navigator.push()` digunakan ketika tombol *Create Product* ditekan dari grid di `MyHomePage` untuk membuka `ProductsFormPage` agar pengguna bisa kembali ke Home. Sedangkan `Navigator.pushReplacement()` digunakan pada menu `LeftDrawer` saat berpindah antara Home dan halaman Form agar halaman sebelumnya tidak menumpuk di stack.

## Bagaimana pemanfaatan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

`Scaffold` dipakai sebagai kerangka layout Material: memiliki `appBar`, `body`, `drawer`, dsb, supaya tampilan aplikasi konsisten. `AppBar` biasanya diletakkan di `Scaffold.appBar` sebagai bar di bagian atas, dan `Drawer` dipasang di `Scaffold.drawer` untuk menu samping.

Dalam *project* ini, `MyHomePage` dan `ProductsFormPage` menggunakan:
```dart
return Scaffold(
    appBar: AppBar(...),
    drawer: const LeftDrawer(),
    body: ...
);
```
**Dampaknya**:
- Halaman bisa memiliki `AppBar` dan `Drawer` yang sama.
- User merasa “masih di aplikasi yang sama”, meskipun pindah dari `Home` ke `Form`, karena kerangka (`Scaffold` + `AppBar` + `Drawer`) tidak berubah.

## Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form?

`Padding` digunakan untuk memberi jarak antarwidget dan dari tepi layar. **Kelebihannya**, tampilan form jadi lebih rapi dan isi teks lebih nyaman dibaca.

`SingleChildScrollView` membungkus satu child (seperti `Column`) agar konten bisa discroll saat melebihi tinggi layar. **Kelebihannya**, semua field form tetap bisa diakses tanpa error “bottom overflow”, bahkan di layar kecil atau saat keyboard muncul.

`ListView` adalah list yang otomatis *scrollable* dan efisien untuk banyak item sejenis. **Kelebihannya**, lebih praktis saat menampilkan data yang jumlahnya banyak atau dinamis.

Contoh penggunaannya di aplikasi ini, di `ProductsFormPage:`
```dart
...
body: Form(
  key: _formKey,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(...),
        Padding(...),
        ...
      ],
    ),
  ),
);
```
Pada potongan kode tersebut, `SingleChildScrollView` membuat seluruh isi form (yang berupa `Column`) bisa discroll ketika konten lebih tinggi dari layar. `Column` menyusun field secara vertikal, sedangkan setiap field dibungkus `Padding` untuk memberi jarak dari tepi layar dan antarfield sehingga tampilan form lebih rapi dan mudah dibaca.

## Bagaimana penyesuaian warna tema agar aplikasi memiliki identitas visual yang konsisten dengan brand toko?

Menggunakan `ThemeData` dan `ColorScheme` supaya warna dan font konsisten di seluruh app, bukan di-*hardcode* di tiap widget.

Pada `MyApp` didefinisikan:
```dart
return MaterialApp(
    ...
    theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
    ),
    home: MyHomePage(),
);
```
```dart
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ...
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    )
}
```

Penyesuaian warna tema dilakukan dengan mendefinisikan palet warna brand sekali di `ThemeData` melalui `ColorScheme` pada `MyApp`. Setelah itu, setiap halaman cukup mengambil warna dari `Theme.of(context).colorScheme` (misalnya `primary` untuk AppBar), sehingga seluruh tampilan aplikasi memiliki warna yang konsisten dan mudah diubah cukup dari satu tempat.

</details>