import 'package:adkosh/models/corpora.dart';
import 'package:adkosh/screens/meaning.dart';
import 'package:adkosh/services/dbServices.dart';
import 'package:flutter/material.dart';

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