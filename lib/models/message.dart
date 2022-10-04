import 'package:flutter/cupertino.dart';

class Message with ChangeNotifier {
  final String text;
  Message({required this.text});
  notifyListeners();
}
