// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kelola_toko/screens/add_product.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kelola_toko/screens/login.dart';

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
    final request = context.watch<CookieRequest>();
    return Material(
      color: menuItem.color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () async => await handleTap(context, request),
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

  handleTap(BuildContext context, CookieRequest request) async {
    if (menuItem.name == "Add Product") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AddProduct()));
    } else if (menuItem.name == "Logout") {
      final response =
          await request.logout("https://kelolatoko-app.fly.dev/auth/logout/");
      String message = response["message"];
      if (response['status']) {
        String uname = response["username"];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$message Sampai jumpa, $uname."),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$message"),
        ));
      }
    }
    final snackbar =
        SnackBar(content: Text('Kamu telah menekan tombol ${menuItem.name}'));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
