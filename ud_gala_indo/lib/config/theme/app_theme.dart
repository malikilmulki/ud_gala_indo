import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Muli',
      useMaterial3: true,
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: Colors.white,
      //   // ···
      //   brightness: Brightness.dark,
      // ),
      primaryColor: Colors.white,
      brightness: Brightness.light,
      appBarTheme: appBarTheme()
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    //color: Colors.white,
    elevation: 0,
    //centerTitle: true,
    //iconTheme: FontAw(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  );
}