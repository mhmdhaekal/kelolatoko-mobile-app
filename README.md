# kelolaToko


## Tugas 8

### Pertanyaan 1

**Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!**

Navigation pada flutter pada dasarnya adalah stack, sehingga ketika ingin melakukan navigasi dilakukan stack dengan halaman lain. Terdapat dua kemungkinan dalam melakukan navigasi yaitu menggunakan `Navigator.push` atau `Navigator.pushReplacement()`. `Navigator.push()` merupakan navigasi dengan cara menambahkan halaman ke dalam `stack` navigasi, sehingga memungkinkan untuk kembali ke halaman sebelumnya (tidak menghapus stack navigasi, history route pengguna tetap tersimpan). `Navigator.pushReplacement()` merupakan navigasi dengan cara mengganti keseluruhan `navigation stack` dengan stack yang baru, sehingga tidak memungkinkan untuk kembali ke halaman sebelumnya. Penggunaan yang cocok:

`Navigator.push()` : Jika pengguna di halaman list item dan ingin melihat halaman detail item, sehingga ketika pengguna ingin kembali ke halaman list dapat menggunakan `back button / gesture back` atau menggunakan method `pop` 

`Navigator.pushReplacement()` : Jika pengguna di halaman login dan sukses login, pengguna akan diarahkan ke halaman `home`. Navigasi yang digunakan adalah `pushReplacement` hal tersebut dikarenakan pengguna tidak membutuhkan kembali page login, dan ketika pengguna melakukan `menekan back button / gesture back` pengguna tidak akan ke halaman login.

### Pertanyaan 2

**Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!**

#### Single-child layout widgets
- align - layout yang menyesuaikan dengan ukuran `child`
- AspectRatio - layout yang menyesuaikan child dengan `aspect ratio` yang diberikan
- baseline - layout yang meletakkan child baseline
- Center - layout yang meletakkan child di center
- ConstrainedBBox - layout widget yang memberikan jarak tambahan di antara child
- Container - layout widget berupa container yang dapat diisi widget (widget dapat didefinisikan posisi, dan ukuran)
- CustomSingleChildLayout - Single Child Layout yang dapat di kustomisasi
- Expanded - Layout widget yang extend dari layout widget row, column, flex untuk mengisi ruang yang tersedia, digunakan untuk layout linear.
- FittedBox - Layout yang meletakkan child sesuai dengan tempat yang tersedia (fit).
- Padding - Layout yang dapat memberikan padding terhadap child.
- SizedBox - Layout box yang dapat didefinisikan panjang dan lebarnya.

### Multi-child layout widgets
- Column - Layout yang meletakkan child secara vertikal.
- Grid - Layout yang meletakkan child dengan pattern yang diberikan (dapat vertikan maupun horizontal).
- ListView - Layout yang dapat discroll dan menampilkan list dari child (widgets).
- Row - Layout yang meletakkan child secara horizontal.

### Pertanyaan 3

**Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!**

- `TextFormField`                 : Elemen input ini digunakan untuk input `product name` dan `product description`, hal ini disebabkan keduanya bertipe String, dan biasanya diinput sesuai dengan keeinginan pengguna.
- `TextFormField - try.parseint`  : Elemen input ini digunakan untuk input `price` dan `stock`, perbedaan utama elemen input ini dibandingkan `TextFormField` adalah dibagian `onChanged` terdapat validasi tambahan yaitu akan mencoba parse string menjadi integer.
- `DropdownButtonFormField`       : Elemen input ini digunakan untuk input `category` berdasarkan dropdown category yang tersedia. 



---
## Tugas 7

### Pertanyaan 1

**Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?**

Sesuai dengan namanya, `stateless widget` adalah widget yang tidak memiliki state, sehingga konten dari widget tersebut immutable (tidak dapat diubah) kecuali dengan di *delete* dan diinisiasikan kembali. Sedangkan `stateful widget` adalah widget yang dapat memiliki state dan harus diikuti dengan impelentasi `state class`, sehingga kontent dari widget tersebut mutable dan dapat berganti sesuai dengan state yang diberikan (dapat berupa variable yang berganti dengan interaksi user), sehingga perbedaan utama antara stateless dan stateful widget, adalah stateless widget dapat tidak dapat memiliki state, sedangkan stateful widget dapat memiliki state.

### Pertanyaan 2

**Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.**

* `MyApp - Stateless widget` - digunakan sebagai root widget dari keseluruhan apps.
    
    Widget yang digunakan:
    - MaterialApp (Widget material 3 dengan konten utama widget MyHomePage)

* `MyHomePage - stateless widget` - digunakan sebagai Home Page yang akan menampilkan button lihat item, tambah produk, logout.

    Widget yang digunakan:
    - Scaffold (Widget untuk implementasi layout managet)
    - appBar (Widget untuk menampilkan bar di header untuk text kelolaToko)
    - SingleChildScrollView (Widget untuk layar yang dapat di scroll)

* `MenuCard - stateless widget` - card yang ditekan untuk menampikan snackbar.

    Widget yang digunakan:
    - Material (Widget untuk based card, dengan background color dan border radius)
    - InkWell (membuat widget dapat ditekan)

### Pertanyaan 3

**Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)**

- Melakukan inisiasi project fultter dengan menggunakan

```bash
flutter create kelola_toko
```

- Mengubah widget `MyApp` menjadi `StatelessWidget`

- Mengubah build dari widget `MyApp`

```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kelolaToko',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
```

- Membuat files menu.dart

- Membuat stateless widget `MyHomePage`

```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
}
```

- Membuat class MenuItem

```dart
class MenuItem {
  final String name;
  final IconData icon;
  final MaterialColor color;

  MenuItem(this.name, this.icon, this.color);
}
```

- Membuat widget MenuCard untuk menampilkan MenuItem
```dart
class MenuCard extends StatelessWidget {
  final MenuItem menuItem;

  const MenuCard(this.menuItem, Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: menuItem.color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => handleTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  menuItem.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(menuItem.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleTap(BuildContext context) {
    final snackbar =
        SnackBar(content: Text('Kamu telah menekan tombol ${menuItem.name}'));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
```

- membuat List MenuItem untuk menginisiasikan menu item
```dart
...
 final List<MenuItem> menuItems = [
    MenuItem("Lihat Item", Icons.view_list, Colors.blue),
    MenuItem("Tambah Produk", Icons.add, Colors.green),
    MenuItem("Logout", Icons.logout, Colors.red)
  ];
...
```

- Mengimplemntasikan build untuk widget MyHomePage

```dart
...
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "kelolaToko",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
            const Text(
              "Welcome to kelolaToko",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: menuItems
                  .map((MenuItem item) => MenuCard(item, Key(item.name)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
...
```

- Menjalankan project flutter di chrome dan android
```bash
flutter run
```
---