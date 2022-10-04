import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'httpexception.dart';
import 'message.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null && _expiryDate!.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCewKq09VHGUBMRqFq1xvLOAoRuASJFkdU');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> logIn(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCewKq09VHGUBMRqFq1xvLOAoRuASJFkdU');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print(response.body);

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addText(Message newMessage) async {
    final url = Uri.parse('https://shop-app-77da4-default-rtdb.firebaseio.com/textInput.json');
    final response = await http.post(url, body: json.encode({'textInput': newMessage.text})).then((response) {
      print(json.decode(response.body));
      print(response.statusCode);
      final message = Message(text: newMessage.text);
      notifyListeners();
    });
  }

  void logOut() {
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
    print('logged out successfully');
  }

  Future<void> deleteUserData() async {
    final url = Uri.parse('https://shop-app-77da4-default-rtdb.firebaseio.com/$_userId.json');
    // final existingUserIndex = Message.where((user) => user.id == _userId);

    final response = await http.delete(url);
    if (response.statusCode == 200) {
      // ignore: unnecessary_string_interpolations
      // ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('${_userId!['id']}')))
      print('done');
    }
    notifyListeners();
  }

  //   Future<void> deleteProduct(String id) async {
  //   final url = 'https://flutter-update.firebaseio.com/products/$id.json';
  //   final existingProductIndex = Message.where((user) => user.id == id);
  //   var existingProduct = _items[existingProductIndex];
  //   _items.removeAt(existingProductIndex);
  //   notifyListeners();
  //   final response = await http.delete(url);
  //   if (response.statusCode >= 400) {
  //     _items.insert(existingProductIndex, existingProduct);
  //     notifyListeners();
  //     throw HttpException('Could not delete product.');
  //   }
  //   existingProduct = null;
  // }
}
