import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<MenuItem> menuItems = [
    MenuItem("Lihat Item", Icons.view_list, Colors.blue),
    MenuItem("Tambah Produk", Icons.add, Colors.green),
    MenuItem("Logout", Icons.logout, Colors.red)
  ];

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
}

class MenuItem {
  final String name;
  final IconData icon;
  final MaterialColor color;

  MenuItem(this.name, this.icon, this.color);
}

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
