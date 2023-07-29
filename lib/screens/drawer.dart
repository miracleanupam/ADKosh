import 'package:adkosh/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ADDrawer extends StatefulWidget {
  const ADDrawer({super.key});

  @override
  State<ADDrawer> createState() => _ADDrawerState();
}

class _ADDrawerState extends State<ADDrawer> {
  String currentSelection = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'अझ धेरै विकल्पहरु!!',
                style: TextStyle(fontSize: 20),
              )),
        ),
        ListTile(
          leading: Icon(Icons.favorite_outline),
          title: Text(
            'फेभरेट शब्दहरु',
            style: TextStyle(fontSize: 20),
          ),
          selected: currentSelection == 'favs',
          onTap: () {
            setState(() {
              currentSelection = "favs";
            });
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Favourites()));
          },
        ),
        Divider(),
        ListTile(
          title: Text('अझ धेरै छिट्टै आउँदैछ!!',
              style: TextStyle(
                fontSize: 20,
              )),
          onTap: () {},
        )
      ],
    ));
  }
}
