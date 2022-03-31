import 'dart:io';

import 'package:buscador_gifs/ui/home_page.dart';
import 'package:flutter/material.dart';



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        hintColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );

  


}
