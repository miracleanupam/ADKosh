import 'package:flutter/material.dart';

class ADDrawer extends StatefulWidget {
  final Function onTapCallback;
  final int selectedItem;

  const ADDrawer({super.key, required this.selectedItem, required this.onTapCallback});

  @override
  State<ADDrawer> createState() => _ADDrawerState();
}

class _ADDrawerState extends State<ADDrawer> {
  int currentSelection = 0;
  @override
  void initState() {
    currentSelection = widget.selectedItem;
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
          selected: currentSelection == 3,
          onTap: () {
            setState(() {
              currentSelection = 3;
            });
            widget.onTapCallback(3);
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.list_alt_outlined),
          title: Text(
            'सङ्केतसूची',
            style: TextStyle(fontSize: 20),
          ),
          selected: currentSelection == 4,
          onTap: () {
            setState(() {
              currentSelection = 4;
            });
            widget.onTapCallback(4);
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'आ्याप बारे',
            style: TextStyle(fontSize: 20),
          ),
          selected: currentSelection == 5,
          onTap: () {
            setState(() {
              currentSelection = 5;
            });
            widget.onTapCallback(5);
            Navigator.pop(context);
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
