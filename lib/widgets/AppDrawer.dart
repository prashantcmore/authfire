import 'package:authfire/screens/screen1.dart';
import 'package:authfire/screens/screen2.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text("Hello Friends"),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text(
            "FirstScreen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: (() => Navigator.of(context).pushReplacementNamed(FirstScreen.routeName)),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(
            "SecondScreen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed(SecondScreen.routeName),
        ),
      ]),
    );
  }
}
