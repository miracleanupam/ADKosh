import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

class CorporaArtha {
  final List<Artha> arthaHaru;

  const CorporaArtha({required this.arthaHaru});
}

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
    Database db = await instance.database;

    List<Map<String, dynamic>> list = rhymes ? await db.rawQuery('select * from corpora where word like ?', ['%$term']) : await db.rawQuery(
        'select * from corpora where word like ? limit 2000', ['$term%']);

    return List.generate(list.length, (index) {
      return Corpora(id: list[index]['id'], word: list[index]['word'],);
    });
  }

  Future<List<Artha>> getWordMeanings({corpora_id}) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> list = await db.rawQuery(
        'select * from meanings where corpora_id == ?', [corpora_id]);

    return List.generate(list.length, (index) {
      return Artha(
          id: list[index]['id'],
          grammar: list[index]['grammar'] ?? '',
          etymology: list[index]['etymology'] ?? '',
          senses: jsonDecode(list[index]['senses'].replaceAll("'", '"')),
          corpora_id: list[index]['corpora_id']);
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
      '''update corpora set favourite = (1 - favourite) where id = ?''', [id]
    );
  }

  Future<bool> isFavourite({id}) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> res = await db.rawQuery('''select favourite from corpora where id =?''', [id]);
    return getAsBool(res[0]['favourite']);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADKosh',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Search(),
    // Text(
    //   'Index 1: Business',
    //   style: optionStyle,
    // ),
    SearchRhyme(),
    RandomScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADकोश'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'खोज',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_outlined),
            label: 'अन्त्यानुप्रास',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'र्यान्डम',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();

  List<Corpora> items = [];
  @override
  void initState() {
    super.initState();
    searchController.addListener(_printLatestValue);

    setInitialItems();
  }

  void setInitialItems() async {

    List<Corpora> res = await DBService.instance.getWordSearchList(term: '');


    res.length > 0
        ? setState(() {
            items = res;
          })
        : setState(() {
            items = [];
          });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _printLatestValue() async {
    List<Corpora> res =
        await DBService.instance.getWordSearchList(term: searchController.text);

    // print(res);

    res.length > 0
        ? setState(() {
            items = res;
          })
        : setState(() {
            items = [];
          });
  }

  void _handleSubmit() {
    print('Submitted the value: ${searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'यहाँ शब्दको अर्थ खोज्नुहोस्...',
          ),
          controller: searchController,
          onSubmitted: ((value) => _handleSubmit()),
        ),
        items.length > 0
            ? Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].word),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Meaning(
                                  id: items[index].id, word: items[index].word),
                            ));
                      },
                    );
                  },
                ),
              )
            : Placeholder()
      ],
    );
  }
}


class SearchRhyme extends StatefulWidget {
  SearchRhyme({super.key});

  @override
  State<SearchRhyme> createState() => _SearchRhymeState();
}

class _SearchRhymeState extends State<SearchRhyme> {
  final searchController = TextEditingController();

  List<Corpora> items = [];
  @override
  void initState() {
    super.initState();
    searchController.addListener(_printLatestValue);

    setInitialItems();
  }

  void setInitialItems() async {

    List<Corpora> res = await DBService.instance.getWordSearchList(term: '', rhymes: true);

    // print(res);

    res.length > 0
        ? setState(() {
            items = res;
          })
        : setState(() {
            items = [];
          });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _printLatestValue() async {
    List<Corpora> res =
        await DBService.instance.getWordSearchList(term: searchController.text, rhymes: true);

    // print(res);

    res.length > 0
        ? setState(() {
            items = res;
          })
        : setState(() {
            items = [];
          });
  }

  void _handleSubmit() {
    print('Submitted the value: ${searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'यहाँ शब्दको अर्थ खोज्नुहोस्...',
          ),
          controller: searchController,
          onSubmitted: ((value) => _handleSubmit()),
        ),
        items.length > 0
            ? Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].word),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Meaning(
                                  id: items[index].id, word: items[index].word),
                            ));
                      },
                    );
                  },
                ),
              )
            : Placeholder()
      ],
    );
  }
}

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  @override
  Widget build(BuildContext context) {
    return Meaning(random: true,);
  }
}


class Meaning extends StatefulWidget {
  int id;
  String word;
  bool random;

  Meaning({super.key, this.id=0, this.word='', this.random=false});

  @override
  State<Meaning> createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  List<Artha> items = [];
  bool favourite = false;

  @override
  void initState() {
    super.initState();

    initializeProcess();
  }

  void initializeProcess() async {
    widget.random ? retrieveRandomWordMeanings() : retrieveMeanings();
  }

   retrieveMeanings() async {
    List<Artha> res =
        await DBService.instance.getWordMeanings(corpora_id: widget.id);
    setState(() {
      items = res;
    });
    doFavoriteStuff();
  }

  void doFavoriteStuff() async {
    bool fav = await DBService.instance.isFavourite(id: widget.id);
    setState(() {
      favourite = fav;
    });
  }

  void retrieveRandomWordMeanings() async {
    Random res = await DBService.instance.getRandomWord();
    // bool fav = await DBService.instance.isFavourite(id: res.corpora_id);

    widget.word = res.word;
    widget.id = res.corpora_id;

    setState(() {
      items = res.arthas;
      // favourite = fav;
    });
    doFavoriteStuff();

  }

  void toggleFavourite() async {
    await DBService.instance.toggleFavourite(id: widget.id);
    setState(() {
      favourite = !favourite;
    });
  }

  Widget shuffleButton() {
    return Center(
            child: ElevatedButton(
              onPressed: () {
                retrieveRandomWordMeanings();
              },
              child: Text('Shuffle'),
            ),
          );
  }

  Widget favouriteButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () { toggleFavourite(); },
        child: favourite ?  Icon(Icons.favorite) : Icon(Icons.favorite_border),
      ),
    );
  }

  String getGrammarEtymologyString(grammar, etymology) {
    if (grammar == '' && etymology == '') {
      return '';
    } else if (grammar == '') {
      return etymology;
    } else if (etymology == '') {
      return grammar;
    } else {
      return '${grammar} | ${etymology}';
    }
  }

  Widget getNewSubtitle(strList) {
    return Expanded(
      child: Column(
        children: strList.map((str) => Text(str)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.random ? null :AppBar(
        title: Text('Go back'),
      ),
      body: Column(
        children: [
          SelectableText('${widget.id}'),
          SelectableText('${widget.word}'),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(getGrammarEtymologyString(
                    items[index].grammar, items[index].etymology)),
                subtitle: Column(
                  children: items[index].senses.map((e) => SelectableText(e)).toList(),
                ),
              );
            },
          )),
          if (widget.random) shuffleButton(),
          favouriteButton(),
        ],
      ),
    );
  }
}