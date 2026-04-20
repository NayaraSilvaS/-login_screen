import 'package:flutter/material.dart';
import 'package:login_screen/presentation/pages/login_page.dart';
import 'package:login_screen/presentation/pages/stats_page.dart';
import 'package:login_screen/presentation/stores/item_store.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ItemStore store = ItemStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFF5F6FA),
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),

      darkTheme: ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF121212),
  cardColor: Color(0xFF1E1E1E),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
  ),
),


      initialRoute: '/',

      routes: {
        '/': (_) => LoginPage(),
        '/home': (_) => HomePage(),
        '/stats': (context) {
  final store =
      ModalRoute.of(context)!.settings.arguments as ItemStore;

  return StatsPage(store: store);
},


      },
    );
  }
}
