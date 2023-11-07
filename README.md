# kelolaToko

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