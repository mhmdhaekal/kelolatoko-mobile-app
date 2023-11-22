// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelola_toko/screens/menu.dart';
import 'package:kelola_toko/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kelola_toko/models/category.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                            "https://kelolatoko-app.fly.dev/create-product-ajax/",
                            jsonEncode(<String, String>{
                              'name': _name,
                              'description': _description,
                              'price': _price.toString(),
                              'stock': _stock.toString(),
                              'category': _category,
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Success adding new product!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Oops! please try again later"),
                          ));
                        }
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
