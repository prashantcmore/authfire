import 'package:authfire/models/message.dart';
import 'package:authfire/widgets/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static const routeName = 'Homescreen';
}

class _HomeScreenState extends State<HomeScreen> {
  var _form = GlobalKey<FormState>();

  bool _isLoading = false;

  var _textInput = TextEditingController();

  var _textData = Message(
    text: '',
  );

  void _saveForm() {
    _form.currentState!.validate();
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    Provider.of<Auth>(context, listen: false).addText(_textData).then((_) => setState(() {
          _isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Users'),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _textInput,
                        decoration: const InputDecoration(hintText: 'TextInput'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        maxLength: 50,
                        onSaved: (value) {
                          _textData = Message(text: value!);
                        },
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'please enter the value';
                          }
                          if (value.length < 15) {
                            return 'please enter at least 10 word';
                          }
                        }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 35,
                        width: 50,
                        child: FlatButton(
                          color: Theme.of(context).accentColor,
                          onPressed: _saveForm,
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
    );
  }
}
