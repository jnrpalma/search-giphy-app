
import 'dart:convert';
import 'dart:io';

import 'package:buscador_gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search;

  int _offset = 0;

  // função para obter gifs através da api
  Future<Map?> _getGifs() async {

    http.Response response;
    if (_search == null || _search!.isEmpty) {
      response = await http.get(
        Uri.parse(
            "https://api.giphy.com/v1/gifs/trending?api_key=6UUyY6H42576gBzQCZa7m2mHj1XtY6j6&limit=20&rating=g"),
      );
      return json.decode(response.body);
    } else {
      response = await http.get(
        Uri.parse(
            "https://api.giphy.com/v1/gifs/search?api_key=88BWAqyy99SWBdEIWtYukU8VOHHkKKTu&q=$_search&limit=19&offset=$_offset&rating=g&lang=en"),
      );
      return json.decode(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {
      print(map);
    });
  }

  int? _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 11),
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise aqui",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _createGifTable(context, snapshot);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data["data"].length)
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data["data"][index]["images"]["fixed_height"]
                    ["url"],
                height: 300.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GifPage(
                      snapshot.data["data"][index]!,
                    ),
                  ),
                );
              },
              onLongPress: () {
                Share.share(snapshot.data["data"][index]["images"]
                    ["fixed_height"]["url"]);
              },
            );
          else
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      "Carregar Mais ...",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    _offset += 19;
                  });
                },
              ),
            );
        });
  }
}
