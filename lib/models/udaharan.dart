class Udaharan {
  final int id;
  final int corpora_id;
  final String usage;

  const Udaharan({
    required this.id,
    required this.corpora_id,
    required this.usage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'corpora_id': corpora_id,
      'usage': usage
    };
  }

  String toString() {
    return 'Example{id: $id, corpora_id: $corpora_id}';
  }
}