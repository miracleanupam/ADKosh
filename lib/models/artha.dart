class Artha {
  final int id;
  final String grammar;
  final String etymology;
  final int corpora_id;
  final List<dynamic> senses;

  const Artha({
    required this.id,
    required this.grammar,
    required this.corpora_id,
    required this.etymology,
    required this.senses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'grammar': grammar,
      'corpora_id': corpora_id,
      'etymology': etymology,
      'senses': senses
    };
  }

  String toString() {
    return 'Meaning{id: $id, corpora_id: $corpora_id}';
  }
}