import 'dart:convert';

import 'package:dictionary_app/src/model/word_definition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class WordInputField extends StatefulWidget {
  const WordInputField({Key? key}) : super(key: key);

  @override
  _WordInputFieldState createState() => _WordInputFieldState();
}

class _WordInputFieldState extends State<WordInputField> {
  final _formKey = GlobalKey<FormState>();
  final wordController = TextEditingController();
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: wordController,
              validator: validateWord,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: ElevatedButton(
                  onPressed: _handleDefinitionButtonPress,
                  child: const Text('Get Definition'),
                ))
          ],
        ));
  }

  String? validateWord(value) {
    return value == null || value.isEmpty || _isNumeric(value)
        ? 'Please provide a valid word'
        : null;
  }

  Future<void> _handleDefinitionButtonPress() async {
    final word = wordController.text;

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      final wordDefinition = await _getWordDefinition(word);
      final definition = wordDefinition.definitions[0].definition;

      logger.i('definition: $definition');
    }
  }

  Future<WordDefinition> _getWordDefinition(String word) async {
    final response = await http.get(
        Uri.parse('https://wordsapiv1.p.rapidapi.com/words/$word/definitions'),
        headers: {
          'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
          'x-rapidapi-key': dotenv.get('WORDS_API_KEY'),
        });

    if (response.statusCode == 200) {
      return WordDefinition.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to retrieve word definition.');
    }
  }

  bool _isNumeric(String result) {
    return double.tryParse(result) != null;
  }
}
