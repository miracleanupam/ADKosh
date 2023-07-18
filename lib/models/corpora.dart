class Corpora {
  final int id;
  final String word;

  const Corpora({
    required this.id,
    required this.word,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
    };
  }

  @override
  String toString() {
    return 'Corpora{id: $id, word: $word}';
  }
}