import 'package:adkosh/models/artha.dart';
import 'package:adkosh/models/random.dart';
import 'package:adkosh/services/dbServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Meaning extends StatefulWidget {
  int id;
  String word;
  bool random;

  Meaning({super.key, this.id = 0, this.word = '', this.random = false});

  @override
  State<Meaning> createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  List<Artha> items = [];
  bool favourite = false;
  int removeFromFavs = 0;

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
    if (favourite) {
      setState(() {
        removeFromFavs = widget.id;
      });
    }
    setState(() {
      favourite = !favourite;
    });
  }

  Widget shuffleButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          retrieveRandomWordMeanings();
        },
        child: Icon(Icons.loop),
        // child: Text('अर्को', style: TextStyle(fontSize: 20),),
      ),
    );
  }

  Widget favouriteButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: ElevatedButton(
        onPressed: () {
          toggleFavourite();
          HapticFeedback.mediumImpact();
        },
        child: favourite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
      ),
    );
  }

  String buildShareText() {
    String textToReturn = widget.word + "\n";
    for (var i = 0; i < items.length; i++) {
      textToReturn +=
          getGrammarEtymologyString(items[i].grammar, items[i].etymology);
      textToReturn += '\n';
      textToReturn += items[i].senses.join("\n");
      textToReturn += "\n";
    }
    return textToReturn;
  }

  Widget shareButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          Share.share(
            buildShareText(),
            subject: "यो शब्द सहि लाग्यो",
          );
        },
        child: Icon(Icons.share),
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
      return '$grammar | $etymology';
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
        appBar: widget.random
            ? null
            : AppBar(
                title: Text('अगाडिको'),
              ),
        body: WillPopScope(
            child: Column(
              children: [
                // SelectableText('${widget.id}'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: SelectableText(
                    '${widget.word}',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          getGrammarEtymologyString(
                              items[index].grammar, items[index].etymology),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      subtitle: Column(
                        children: items[index]
                            .senses
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SelectableText(
                                    e,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    );
                  },
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    favouriteButton(),
                    if (widget.random) shuffleButton(),
                    shareButton(),
                  ],
                )
                // if (widget.random) shuffleButton(),
                // favouriteButton(),
              ],
            ),
            onWillPop: () async {
              Navigator.pop(context, removeFromFavs);
              return false;
            }));
  }
}
