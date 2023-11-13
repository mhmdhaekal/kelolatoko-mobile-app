import 'package:flutter/material.dart';
import 'package:kelola_toko/widgets/menu_card.dart';
import 'package:kelola_toko/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<MenuItem> menuItems = [
    MenuItem("Item List", Icons.view_list, Colors.blue),
    MenuItem("Add Product", Icons.add, Colors.green),
    MenuItem("Logout", Icons.logout, Colors.red)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "kelolaToko",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
