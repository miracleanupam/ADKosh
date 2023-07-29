import 'package:adkosh/screens/drawer.dart';
import 'package:adkosh/screens/random.dart';
import 'package:adkosh/screens/search.dart';
import 'package:adkosh/screens/searchRhyme.dart';
import 'package:adkosh/theme/themeManager.dart';
import 'package:flutter/material.dart';

ThemeManager _themeManager = ThemeManager();

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Search(),
    SearchRhyme(),
    RandomScreen(),
  ];

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {
        print("Dash theme listener ");
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ADDrawer(),
      appBar: AppBar(
        title: const Text('ADकोश'),
        actions: [
          Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) {
              print("TUrning on/off dark theme with switch");
              _themeManager.toggleTheme(newValue);
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'खोज',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_outlined),
            label: 'अन्त्यानुप्रास',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'र्‍याण्डम',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
