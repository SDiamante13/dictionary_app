import 'package:flutter/material.dart';

class WordInputField extends StatefulWidget {
  const WordInputField({Key? key}) : super(key: key);

  @override
  _WordInputFieldState createState() => _WordInputFieldState();
}

class _WordInputFieldState extends State<WordInputField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: ElevatedButton(
                  onPressed: _getDefinition,
                  child: const Text("Get Definition"),
                ))
          ],
        ));
  }

  void _getDefinition() {
    print("Button pressed");
  }
}
