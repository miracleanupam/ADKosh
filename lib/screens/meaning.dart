import 'package:adkosh/models/artha.dart';
import 'package:adkosh/models/random.dart';
import 'package:adkosh/services/dbServices.dart';
import 'package:flutter/material.dart';

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