import 'package:adkosh/screens/dashboard.dart';
import 'package:adkosh/theme/themeConstants.dart';
import 'package:adkosh/theme/themeManager.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
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
      themeMode: themeManager.themeMode,
      home: Dashboard(tManager: themeManager,),
    );
  }
}

