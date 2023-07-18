import 'package:adkosh/models/corpora.dart';
import 'package:adkosh/screens/drawer.dart';
import 'package:adkosh/screens/meaning.dart';
import 'package:adkosh/services/dbServices.dart';
import 'package:flutter/material.dart';

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

    res.length > 0 ? setState(() {
     items = res; 
    }) : setState(() {
      items = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ADDrawer(),
      appBar: AppBar(
        title: Text('फेभरेट शब्दहरु'),
      ),
      body: Column(
        children: [
          items.length > 0 ? Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].word),
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Meaning(id: items[index].id, word: items[index].word,))
                    );
                  },
                );
              },
            ),
          ) : Placeholder()
        ],
      ),
    );
  }
}