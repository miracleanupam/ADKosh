import 'package:adkosh/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ADDrawer extends StatefulWidget {
  const ADDrawer({super.key});

  @override
  State<ADDrawer> createState() => _ADDrawerState();
}

class _ADDrawerState extends State<ADDrawer> {
  int currentSelection = 0;
  @override
  void initState() {
    super.initState();
    print("initialize vayo");
    setState(() {
      currentSelection = 0;
    });
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
            onTap: () {
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