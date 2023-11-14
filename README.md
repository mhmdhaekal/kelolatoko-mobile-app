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

### Pertanyaan 4

**Bagaimana penerapan clean architecture pada aplikasi Flutter?**

Penerapan clean architectur pada aplikasi flutter adalah dengan cara membagi aplikasi menjadi beberapa layers yaitu:

- Presentation Layer : Layer yang berhubungan dengan interaksi user dengan aplikasi, terdiri dari:
    - Pages
    - State Management
    - Widgets

- Domain Layer        : Layer yang tidak memiliki dependencies dengan layer lain, dan layer yang mendefinisikan logic, entities, dan business model dari aplikasi, terdiri dari:
    - Entities
    - Repository Interfaces
    - Use Cases

- Data Layer          : Layer yang terdiri atas sumber dari data yang digunakan dalam aplikasi, terdiri dari:
    - Repositories
    - Data Sources
    - Models


### Pertanyaan 5

**Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)**

- Menerapkan clean architechture, dengan membuat folders screens dan widgets, lalu memindahkan `menu.dart` ke folder screen, dan memindahkan widgets `MenuItem` ke files `menu_card.dart` yang berada di `/widgets`. 
- Membuat files `left_drawer.card` yang berada di directory `/widgets`.
- Mengimplementasikan `left_drawer.card`
  
```dart
import 'package:flutter/material.dart';
import 'package:kelola_toko/screens/menu.dart';
import 'package:kelola_toko/screens/add_product.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              child: Text(
            "KelolaToko",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
          ListTile(
            leading: const Icon(
              Icons.view_list,
              color: Colors.white,
            ),
            title: const Text("Home", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            title: const Text("Add Product",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AddProduct()));
            },
          ),
        ],
      ),
    );
  }
}
```

- Menampilkan `left_drawer` di screens `menu.dart`

```dart
...
  drawer: const LeftDrawer(),
...
```
- Membuat halaman `add_product.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:kelola_toko/widgets/left_drawer.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _description = "";
  int _price = 0;
  int _stock = 0;
  String _category = "";

  List<String> categories = <String>[
    "None",
    "Mouse",
    "Keyboard",
    "Monitor",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "Add Product",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            )),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Product Name",
                      labelText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Product name cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Price",
                      labelText: "Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.tryParse(value!) ?? _price;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Price cannot be empty!";
                    }

                    if (int.tryParse(value) == null) {
                      return "Price must be a number!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Stock",
                      labelText: "Stock",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onChanged: (String? value) {
                    setState(() {
                      _stock = int.tryParse(value!) ?? _stock;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Stock cannot be empty!";
                    }

                    if (int.tryParse(value) == null) {
                      return "Stock must be a number!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      hintText: "Category",
                      labelText: "Category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Category cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Text("Product successfully saved!"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Product name: $_name'),
                                      Text('Description: $_description'),
                                      Text('Price: $_price'),
                                      Text('Stock: $_stock'),
                                      Text('Category: $_category'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              );
                            });
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      "Save Product",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

- menambahkan navigator di `menu.dart` ketika menekan button `add_product.dart`
```dart
...
  if (menuItem.name == "Add Product") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AddProduct()));
    }
...
```
  

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