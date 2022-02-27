class Definition {
  final String definition;
  final String partOfSpeech;

  const Definition({
    required this.definition,
    required this.partOfSpeech,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'],
      partOfSpeech: json['partOfSpeech'],
    );
  }

  @override
  String toString() {
    return 'Definition{definition: $definition, partOfSpeech: $partOfSpeech}';
  }
}
