import 'package:flutter/material.dart';
import 'package:http_request/pages/favorites.dart';
import 'package:http_request/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students App',
      initialRoute: "/",
      routes: {
        "/":(context)=>HomePage(),
        "/favorites":(context)=>FavoritesPage()
      },
    );
  }
}
