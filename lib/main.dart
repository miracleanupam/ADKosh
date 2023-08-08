import 'package:adkosh/screens/drawer.dart';
import 'package:adkosh/screens/favorites.dart';
import 'package:adkosh/screens/index.dart';
import 'package:adkosh/screens/random.dart';
import 'package:adkosh/screens/search.dart';
import 'package:adkosh/screens/searchRhyme.dart';
import 'package:adkosh/theme/themeConstants.dart';
import 'package:adkosh/theme/themeManager.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      setState(() {});
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ADKosh',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  int _drawerIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Search(),
    SearchRhyme(),
    RandomScreen(),
    Favourites(),
    IndexScreen(),
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
      setState(() {});
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _drawerIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: ADDrawer(selectedItem: _drawerIndex, onTapCallback: (val) {
        setState(() {
          _drawerIndex = val;
          _selectedIndex = -1;
        });
      }),
      appBar: AppBar(
        title: const Text('ADकोश'),
        actions: [
          IconButton(
              onPressed: () {
                _themeManager.toggleTheme(
                    _themeManager.themeMode == ThemeMode.dark ? false : true);
              },
              icon: Icon(
                _themeManager.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_drawerIndex > 0 ? _drawerIndex : _selectedIndex),
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
        currentIndex: _selectedIndex < 0 ? 0 : _selectedIndex,
        selectedItemColor: _selectedIndex < 0 ? Colors.grey[100] : Colors.amber[800],
        unselectedItemColor: _selectedIndex < 0 ? Colors.grey[100] : Colors.white,
        selectedFontSize: _selectedIndex < 0 ? 12 : 14,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
