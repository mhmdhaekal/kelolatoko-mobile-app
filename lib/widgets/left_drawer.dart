import 'package:flutter/material.dart';
import 'package:kelola_toko/screens/add_category.dart';
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
          ListTile(
            leading: const Icon(
              Icons.category,
              color: Colors.white,
            ),
            title: const Text("Add Category",
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AddCategory()));
            },
          ),
        ],
      ),
    );
  }
}
