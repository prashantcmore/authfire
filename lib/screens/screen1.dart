import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';
import '../screens/homeScreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);
  static const routeName = 'first screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Container(
          height: 45,
          width: 350,
          color: Colors.red,
          child: FlatButton(
            child: const Text(
              'Delete',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).deleteUserData();
            },
          ),
        ),
      ),
    );
  }
}
