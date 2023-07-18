import 'package:adkosh/models/artha.dart';

class Random {
  final String word;
  final List<Artha> arthas;
  final int corpora_id;

  const Random({
    required this.word,
    required this.corpora_id,
    required this.arthas,
  });

  Map<String, dynamic> toMap() {
    return {'word': word, 'arthas': arthas, 'corpora_id': corpora_id};
  }

  String toString() {
    return 'Random(word: $word)';
  }
}