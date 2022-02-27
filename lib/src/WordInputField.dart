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
  final wordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: wordController,
              validator: (value) {
                if (value == null || value.isEmpty || _isNumeric(value)) {
                  return 'Please provide a valid word';
                }
                return null;
              },
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
    final word = wordController.text;

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      var data = await http.get(
          Uri.parse('https://wordsapiv1.p.rapidapi.com/words/$word/definitions'),
          headers: {
            'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
            'x-rapidapi-key': dotenv.get('WORDS_API_KEY'),
          });
      print("Get data: ${data.body}");
    }
  }

  bool _isNumeric(String result) {
    return double.tryParse(result) != null;
  }
}
