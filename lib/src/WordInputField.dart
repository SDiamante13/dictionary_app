import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _getDefinition() async {
    const word = 'courage';

    var data = await http.get(
        Uri.parse('https://wordsapiv1.p.rapidapi.com/words/$word/definitions'),
        headers: {
          'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
          'x-rapidapi-key': dotenv.get('WORDS_API_KEY'),
        });
    print("Get data: ${data.body}");
  }
}
