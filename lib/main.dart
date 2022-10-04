import 'package:authfire/models/Auth.dart';
import 'package:authfire/screens/AuthScreen.dart';
import 'package:authfire/screens/homeScreen.dart';
import 'package:authfire/screens/screen1.dart';
import 'package:authfire/screens/screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider<Auth>(create: (_) => Auth())],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.purple,
                  ),
                  home:
                      // HomeScreen(),
                      AuthScreen(),
                  routes: {
                    AuthScreen.routeName: (context) => AuthScreen(),
                    HomeScreen.routeName: (ctx) => HomeScreen(),
                    FirstScreen.routeName: (ctx) => FirstScreen(),
                    SecondScreen.routeName: (ctx) => SecondScreen(),
                  },
                )));
  }
}
