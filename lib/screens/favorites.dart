import 'package:adkosh/models/corpora.dart';
import 'package:adkosh/screens/meaning.dart';
import 'package:adkosh/services/dbServices.dart';
import 'package:adkosh/widgets/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Corpora> items = [];

  @override
  void initState() {
    super.initState();
    setItems();
  }

  void setItems() async {
    List<Corpora> res = await DBService.instance.getAllFavorites();

    res.length > 0
        ? setState(() {
            items = res;
          })
        : setState(() {
            items = [];
          });
  }

  void removeWord(cor) {
    List<Corpora> tempItems = items;
    tempItems.removeWhere((el) {
      return el.id == cor;
    });
    setState(() {
      items = tempItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
          children: [
            items.length > 0
                ? Expanded(
                    child: ListView.separated(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            items[index].word,
                            style: TextStyle(fontSize: 20),
                          ),
                          onTap: () async {
                            HapticFeedback.mediumImpact();
                            final unfavourited_word = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Meaning(
                                          id: items[index].id,
                                          word: items[index].word,
                                        )));
    
                            if (unfavourited_word != 0) {
                              removeWord(unfavourited_word);
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          indent: 8,
                          endIndent: 8,
                        );
                      },
                    ),
                  )
                : NoResults()
          ],
        ),
    );
  }
}
