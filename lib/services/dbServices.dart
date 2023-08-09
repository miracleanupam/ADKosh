import 'dart:convert';
import 'dart:io';

import 'package:adkosh/models/artha.dart';
import 'package:adkosh/models/corpora.dart';
import 'package:adkosh/models/random.dart';
import 'package:adkosh/models/udaharan.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  DBService._privateConstructor();
  static final DBService instance = DBService._privateConstructor();

  // static Database _database;

  bool getAsBool(num) {
    return num == 0 ? false : true;
  }

  Future<Database> get database async {
    return await _initializeDB();
  }

  Future _initializeDB() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, "shabda.sqlite3");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data =
          await rootBundle.load(join("assets", "db", "shabda.sqlite3"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future<List<Corpora>> getWordSearchList({term = '', rhymes = false}) async {
    term = rhymes ? term.replaceAll('ी', 'ि').replaceAll('ू', 'ु') : term;
    Database db = await instance.database;

    List<Map<String, dynamic>> list = rhymes
        ? await db
            .rawQuery('select * from corpora where word like ? limit 2000', [term.isEmpty ? '%' : term])
        : await db.rawQuery(
            "select * from corpora where replace(replace(word, 'ी', 'ि'), 'ू', 'ु') like ? limit 2000", ['$term%']);

    return List.generate(list.length, (index) {
      return Corpora(
        id: list[index]['id'],
        word: list[index]['word'],
      );
    });
  }

  Future<List<Artha>> getWordMeanings({corpora_id}) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> list = await db
        .rawQuery('select * from meanings where corpora_id == ?', [corpora_id]);

    return List.generate(list.length, (index) {
      return Artha(
          id: list[index]['id'],
          grammar: list[index]['grammar'] ?? '',
          etymology: list[index]['etymology'] ?? '',
          senses: jsonDecode(list[index]['senses'].replaceAll("'", '"')),
          corpora_id: list[index]['corpora_id']);
    });
  }

  Future<List<Udaharan>> getWordUsageExamples({corpora_id}) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> list = await db
        .rawQuery('select * from examples where corpora_id == ?', [corpora_id]);

    return List.generate(list.length, (index) {
      return Udaharan(id: list[index]['id'], corpora_id: list[index]['corpora_id'], usage: list[index]['usage']);
    });
  }

  Future<Random> getRandomWord() async {
    Database db = await instance.database;

    List<Map<String, dynamic>> randomWordMeaning = await db.rawQuery(
        'select m.id as m_id, c.word as word, m.grammar as grammar, m.etymology as etymology, m.senses as senses, m.corpora_id as corpora_id from corpora c inner join meanings m on c.id == m.corpora_id where corpora_id == (select id from corpora order by random() limit 1)');

    return Random(
        word: randomWordMeaning[0]['word'],
        corpora_id: randomWordMeaning[0]['corpora_id'],
        arthas: List.generate(randomWordMeaning.length, (index) {
          return Artha(
              id: randomWordMeaning[index]['m_id'],
              grammar: randomWordMeaning[index]['grammar'] ?? '',
              corpora_id: randomWordMeaning[index]['corpora_id'],
              etymology: randomWordMeaning[index]['etymology'] ?? '',
              senses: jsonDecode(
                  randomWordMeaning[index]['senses'].replaceAll("'", '"')));
        }));
  }

  Future<void> toggleFavourite({id}) async {
    Database db = await instance.database;

    var res = await db.rawUpdate(
        '''update corpora set favourite = (1 - favourite) where id = ?''',
        [id]);
  }

  Future<bool> isFavourite({id}) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> res = await db
        .rawQuery('''select favourite from corpora where id =?''', [id]);
    return getAsBool(res[0]['favourite']);
  }

  Future<List<Corpora>> getAllFavorites() async {
    Database db = await instance.database;

    List<Map<String, dynamic>> list =
        await db.rawQuery('''select * from corpora where favourite == 1''');

    return List.generate(list.length, (index) {
      return Corpora(
        id: list[index]['id'],
        word: list[index]['word'],
      );
    });
  }
}
