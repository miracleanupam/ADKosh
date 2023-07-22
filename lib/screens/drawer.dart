import 'package:adkosh/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ADDrawer extends StatefulWidget {
  const ADDrawer({super.key});

  @override
  State<ADDrawer> createState() => _ADDrawerState();
}

class _ADDrawerState extends State<ADDrawer> {
  String currentSelection = "favs";
  @override
  void initState() {
    super.initState();
    print("initialize vayo");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('अझ धेरै विकल्पहरु!!'),
          ),
          ListTile(
            title: Text('फेभरेट शब्दहरु'),
            selected: currentSelection == 'favs',
            onTap: () {
                setState(() {
                currentSelection = "favs";
              });
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites()));
            },
          ),
          ListTile(
            title: Text('अझ धेरै छिट्टै आउँदैछ!!'),
            onTap: () {
              
            },
          )
        ],
      )
    );
  }
}