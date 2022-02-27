import 'definition.dart';

class WordDefinition {
  final String word;
  final List<Definition> definitions;

  const WordDefinition({
    required this.word,
    required this.definitions,
  });

  factory WordDefinition.fromJson(Map<String, dynamic> json) {
    var list = json['definitions'] as List;
    List<Definition> definitionList =
        list.map((i) => Definition.fromJson(i)).toList();

    return WordDefinition(
      word: json['word'],
      definitions: definitionList,
    );
  }

  @override
  String toString() {
    return 'WordDefinition{word: $word, definitions: $definitions}';
  }
}
