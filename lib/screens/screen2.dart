import 'package:authfire/screens/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';
import 'homeScreen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  static const routeName = 'second screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
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
              'LogOut',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
