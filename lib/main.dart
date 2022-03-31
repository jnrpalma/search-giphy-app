import 'dart:io';

import 'package:buscador_gifs/my_http_override.dart';
import 'package:buscador_gifs/ui/home_page.dart';
import 'package:flutter/material.dart';


void main() {
  HttpOverrides.global = MyHtppOverride();
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
