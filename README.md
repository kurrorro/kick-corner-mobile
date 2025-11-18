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

<details>
<summary><strong>Tugas Individu 8</strong></summary>

## Mengapa perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model?

Alasan membuat model Dart:

1. **Type safety & null-safety**  
   - Dengan model, setiap field punya tipe yang jelas (`int`, `String`, `bool`, `DateTime`, dll.) sehingga dicek di compile time sesuai sistem *sound null safety* milik Dart.
   - Ini mencegah error runtime seperti akses `null` pada field yang seharusnya non-null.

2. **Validasi dan transformasi terpusat**  
   - Logika parsing JSON (misalnya `DateTime.parse(json["created_at"])`, atau fallback bila `thumbnail` kosong) ditempatkan di `fromJson`.  
   - Kalau format backend berubah, cukup ubah di satu tempat, bukan di semua widget.

3. **Maintainability & readability**  
   - Kode yang memakai objek kuat seperti `ProductsEntry` jauh lebih mudah dibaca (misalnya `product.name`, `product.price`) dibanding bertebaran `map['name']`, `map['price']` yang sifatnya dinamis dan raw JSON.  
   - Praktik ini juga direkomendasikan di dokumentasi Flutter pada bagian JSON & serialization: response HTTP sebaiknya dikonversi ke *custom Dart object* sebelum dipakai.
 
Kalau langsung pakai `Map<String, dynamic>` tanpa model:

- **Rentan typo & error runtime**: salah tulis key (`"thumnail"` bukannya `"thumbnail"`) tidak terdeteksi sebelum runtime.
- **Tidak ada kontrak tipe**: field bisa berisi tipe yang berbeda-beda (misalnya `price` string vs int), berpotensi menyebabkan crash saat dipakai.
- **Sulit di-maintain**: saat jumlah field bertambah (seperti `isFeatured`, `productViews`, `createdAt`), semua bagian kode yang mengakses Map harus diubah manual.

## Fungsi package http dan CookieRequest dalam tugas ini dan perbedaan perannya

**`http` package**  
- Disediakan komunitas Flutter untuk melakukan request HTTP (GET/POST/PUT/DELETE) secara sederhana, multiplatform.
- Biasanya dipakai langsung saat kita tidak perlu manajemen *session cookie* yang kompleks.

**`CookieRequest` (dari `pbp_django_auth`)**  
- Dibangun khusus untuk integrasi dengan Django auth.  
- Menyimpan dan mengirim cookie `sessionid` dan `csrftoken` secara otomatis untuk setiap request setelah login, sehingga state login Django ikut terbawa.
- Digunakan di *project* ini untuk:
  - `postJson` ke endpoint `/auth/login/` dan `/auth/register/`,
  - `get('http://localhost:8000/json/')` untuk mengambil list produk,
  - `postJson('/products/create-flutter/')`, `postJson('/products/edit-flutter/<id>/')`, dan `/products/delete-flutter/<id>/`.

**Perbedaan peran utama**:

- `http`: *generic HTTP client*, tidak tahu apa itu Django, session, atau CSRF.
- `CookieRequest`: *HTTP client dengan state autentikasi Django*, otomatis menyimpan cookie dan memudahkan endpoint yang butuh user login tanpa menulis logika cookie manual.

## Mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter?

**Session konsisten di seluruh aplikasi**
- Setelah login berhasil, cookie session dan csrf token tersimpan di satu objek `CookieRequest`.
- Kalau tiap halaman membuat `CookieRequest` baru, cookie tidak terbawa sehingga Django menganggap user belum login.

**Single source of truth untuk auth state**
- Dengan satu instance global, kita mudah mengecek apakah user sudah login, menampilkan menu yang sesuai, dan mengirim request yang nyambung ke Django.

**Memudahkan dependency injection & testing**
- Sesuai best practice Flutter ketika membagi shared objects seperti client network ke seluruh widget tree menggunakan package provider.

## Bagaimana konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

Beberapa konfigurasi penting yang dilakukan di *project* ini:

**ALLOWED_HOSTS di Django**

Menambahkan di `settings.py`:
```python
ALLOWED_HOSTS = ["localhost", "127.0.0.1", ..., "10.0.2.2",]
```

`10.0.2.2` adalah alamat khusus yang dipakai Android emulator untuk mengakses localhost mesin host. Kalau tidak ditambahkan, Django akan menolak request dengan error “Invalid HTTP_HOST header”.

**CORS (Cross-Origin Resource Sharing)**

Menginstal dan menambahkan `django-cors-headers` ke `INSTALLED_APPS` dan `MIDDLEWARE`, lalu mengaktifkan:

```python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
```

CORS diperlukan ketika frontend (Flutter atau aplikasi lain) mengakses API dari origin yang berbeda. Paket ini menambahkan header CORS yang tepat sehingga browser mengizinkan request lintas origin.

**Pengaturan cookie & SameSite**

Menambahkan beberapa pengaturan variabel di `settings.py`:

```python
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```

- `*_SECURE = True` memastikan cookie hanya dikirim lewat koneksi HTTPS.
- `*_SAMESITE = 'None'` mengizinkan cookie dikirim di request cross-site (misal dari Flutter Web / domain lain) selama juga ditandai Secure.

Kalau pengaturan ini tidak benar, browser bisa menolak mengirim cookie `sessionid` / `csrftoken`, sehingga dari sisi Django pengguna akan selalu terlihat belum login meskipun sudah berhasil login dari Flutter.

**Izin Internet di Android**

Di `AndroidManifest.xml` saya menambahkan:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

seperti yang direkomendasikan dokumentasi Android. Tanpa permission ini, aplikasi Android tidak bisa melakukan request jaringan sama sekali, sehingga semua request ke Django gagal.

**Jika salah satu konfigurasi di atas tidak benar**:

- Request bisa blocked oleh Django (`ALLOWED_HOSTS`), oleh `CORS` (khusus web), atau oleh sistem operasi (tidak ada INTERNET permission).
- Cookie tidak terkirim -> Django selalu menganggap user belum login -> fitur yang butuh autentikasi (lihat “My Products”, create/edit/delete) tidak bisa jalan.

## Mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter

**Input di Flutter (ProductsFormPage)**

- User mengisi form: name, price, description, thumbnail, category, isFeatured, stock, brand, size.
- `TextFormField` + `DropdownButtonFormField` + `SwitchListTile` digunakan dengan validator untuk memastikan data valid sebelum dikirim.

**Mengirim data ke Django**

- Ketika tombol Submit ditekan dan form valid,
  ```dart
  final response = await request.postJson(
  'http://.../products/create-flutter/',
    jsonEncode({
      "name": _name,
      "price": _price,
      "description": _description,
      "thumbnail": _thumbnail,
      "category": _category,
      "is_featured": _isFeatured,
      "stock": _stock,
      "brand": _brand,
      "size": _size,
    }),
  );
  ```
  `CookieRequest` mengirim HTTP POST dengan body JSON ke Django.

- **Django memproses request**
  View `create_product_flutter` membaca request.body, parse JSON, lalu membuat instance `Product` baru yang terasosiasi dengan `request.user` dan menyimpannya ke database.

- **Response kembali ke Flutter**
  - Django mengembalikan JSON dengan "status": "success" atau pesan error.
  - Di Flutter, cek response['status'] dan menampilkan SnackBar apakah produk berhasil dibuat atau tidak.

- **Menampilkan data di daftar produk**
  Di Flutter, halaman home (list produk):
  ```dart
  Future<List<ProductsEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');
    final List<ProductsEntry> list = [];
    for (final d in response) {
      if (d != null) {
        list.add(ProductsEntry.fromJson(d));
      }
    }
    return list;
  }
  ```

  - `request.get(...)` mengambil data dari Django dalam bentuk `List<dynamic>`.  
  - Lalu aku loop satu per satu elemen `response`, dan kalau tidak `null` dikonversi menjadi objek `ProductsEntry` lewat `ProductsEntry.fromJson(d)`, lalu dimasukkan ke `list`.  
  - `FutureBuilder` menerima `Future<List<ProductsEntry>>` ini, dan menampilkan setiap produk menggunakan `ProductsEntryCard` di dalam `ListView.builder`.

## Mekanisme autentikasi dari login, register, hingga logout

**Register**

- Di halaman `RegisterPage`, user mengisi username, password1, password2.
- Flutter memanggil:
  ```dart
  final response = await request.postJson(
    "http://localhost:8000/auth/register/",
    jsonEncode({
      "username": username,
      "password1": password1,
      "password2": password2,
    }),
  );
  ```
- View `register` di Django:
  - Membaca JSON,
  - Memastikan password cocok dan username belum dipakai,
  - Memanggil `User.objects.create_user(...)`,
  - Mengembalikan JSON "status": "success" jika berhasil.

**Login**

- Di `LoginApp`, user mengisi username dan password.
- Flutter memanggil:
  ```dart
  final response = await request.login(
    "http://localhost:8000/auth/login/",
    {
      "username": username,
      "password": password,
    },
  );
  ```
- View `login` di Django
  - Memanggil `authenticate(username=..., password=...)`,
  - Jika berhasil, memanggil `auth_login(request, user)` -> Django membuat session dan mengirim cookie `sessionid` ke client.
  - `CookieRequest` menyimpan cookie itu sehingga request berikutnya dikenali sebagai user yang sudah login.
- Setelah login berhasil, halaman akan diarahkan ke halaman utama (main).

**Logout**

- Dari `LeftDrawer`, tombol Logout memanggil:
  ```dart
  await request.logout("http://localhost:8000/auth/logout/");
  ```
- Django memanggil `logout(request)` sehingga session dihapus dan cookie tidak lagi valid.
- Di Flutter, setelah logout, arahkan user kembali ke halaman `LoginApp`.

## Implementasi checklist

- **Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik**

  - Menjalankan Django di lokal (`python manage.py runserver`) dan di server deployment.
  - Mengecek endpoint utama (`/`,` /json/`, `/auth/login/`, `/auth/register/`) via browser untuk memastikan tidak ada error.

- **Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter**

  - Membuat `register.dart` berisi `RegisterPage` dengan form `TextFormField` untuk username dan password.
  - Menambahkan validasi password dan pemanggilan `request.postJson` ke `/auth/register/`.
  - Menampilkan `SnackBar` untuk feedback berhasil/gagal

- **Membuat halaman login pada proyek tugas Flutter**

  - Membuat `login.dart` dengan `LoginApp`.
  - Menggunakan `CookieRequest.postJson` ke `/auth/login/`.
  - Jika status berhasil, menyimpan state login (melalui `CookieRequest`) dan `Navigator.pushReplacement` ke `MyHomePage`.

- **Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter**

  - Menambahkan endpoint login, register, logout di Django (`authentication/views.py`)
  - Mengaktifkan session & middleware auth di `settings.py`.
  - Menggunakan `request.user` di view `create_product_flutter`, `edit_product_flutter`, dan `delete_product_flutter` untuk menghubungkan produk dengan user yang login.
  - Menggunakan `pbp_django_auth` di Flutter dan membagi `CookieRequest` melalui Provider.

- **Membuat model kustom sesuai dengan proyek aplikasi Django**

  - Meng-convert data JSON ke bentuk Dart menggunakan `app.quicktype.io`

- **Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy**

  - Endpoint Django `/json/` mengembalikan list produk dalam bentuk JSON.
  - Di Flutter, `MyHomePage` menggunakan `FutureBuilder` + `fetchProducts(request)` yang memanggil `request.get('http://.../json/')` dan menampilkan daftar dengan `ProductsEntryCard`.

  - **Tampilkan name, price, description, thumbnail, category, dan is_featured dari masing-masing item pada halaman ini (Dapat disesuaikan dengan field yang kalian buat sebelumnya)** </br>

    `ProductsEntryCard` menampilkan:
    - Gambar thumbnail (via `Image.network` dan endpoint proxy gambar),
    - Nama produk (`products.name`),
    - Harga (`products.price`),
    - Deskripsi singkat,
    - Category badge (misal Jersey/Shoes),
    - Badge “Featured” bila `isFeatured == true`

**Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.**

  - Membuat `products_detail.dart` berisi `ProductDetailPage` yang menerima `ProductsEntry`.
  - Saat menekan card, `Navigator.push` ke `ProductDetailPage(product: product)`.

  - **Halaman ini dapat diakses dengan menekan salah satu card item pada halaman daftar Item** </br>
    Di `ProductsEntryCard` menerima `onTap`, dan di `MyHomePage`:
    ```dart
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ),
      );
    }
    ```

  - **Tampilkan seluruh atribut pada model item kamu pada halaman ini** </br>
    `ProductDetailPage` menampilkan:
    - Gambar penuh, badge category/Featured/Hot,
    - Name,
    - Created date, views, brand, size, stock,
    - Price,
    - Description lengkap.

  - **Tambahkan tombol untuk kembali ke halaman daftar item**
    - Terdapat di `AppBar` (`Navigator.pop`).

**Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login**
  - Menggunakan enum:
    ```dart
    enum ProductFilter { all, my, featured }
    ```
  - Mengambil `currentUserId` dari `request.jsonData['id']`
  - Di Flutter, daftar produk disaring dengan:
    ```dart
    final filtered = allProducts.where((p) {
      switch (_activeFilter) {
        case ProductFilter.all:
          return true;
        case ProductFilter.my:
          return currentUserId != null &&
                p.userId.toString() == currentUserId.toString();
        case ProductFilter.featured:
          return p.isFeatured;
      }
    }).toList();
    ```
    Sehingga:
    - All Product -> semua produk
    - My Product -> hanya produk milik user yang login
    - Featured -> hanya produk unggulan (`is_featured == tru`e)

</details>