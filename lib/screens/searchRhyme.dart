import 'package:adkosh/models/corpora.dart';
import 'package:adkosh/screens/meaning.dart';
import 'package:adkosh/services/dbServices.dart';
import 'package:adkosh/widgets/not_found.dart';
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
    searchController.addListener(_dbConnector);

    setInitialItems();
  }

  void setInitialItems() async {
    List<Corpora> res =
        await DBService.instance.getWordSearchList(term: '', rhymes: true);

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

  void _dbConnector() async {
    List<Corpora> res = await DBService.instance
        .getWordSearchList(term: searchController.text, rhymes: true);

    res.length > 0
        ? setState(() {
            items = res;
          })
        : setState(() {
            items = [];
          });
  }

  // void _handleSubmit() {
  //   print('Submitted the value: ${searchController.text.trim()}');
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'यहाँ शब्दको अर्थ खोज्नुहोस्...',
                suffixIcon: Tooltip(
                  key: tooltipkey,
                  triggerMode: TooltipTriggerMode.tap,
                  showDuration: Duration(seconds: 30),
                  message:
                      '% - शून्य वा बढी वर्ण वा मात्रा \n _ - एउटा वर्ण वा मात्रा \n उदाहरण: \n %ाम - राम, आराम, बिराम, अछाम, इनाम ... \n म% - मल, मकल, मकुन्द, मखमा ... \n र_म - रकम, राम, रसम, रोम ...',
                  child: Icon(Icons.info_outline),
                )),
            style: TextStyle(fontSize: 20),
            controller: searchController,
          ),
        ),
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
    );
  }
}
