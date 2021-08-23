import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var request =
    Uri.parse('https://api.hgbrasil.com/finance?format=json&key=f6b73b8f');

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
    ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "\$ Conversor de Moedas \$",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case (ConnectionState.none):
            case (ConnectionState.waiting):
              return Center(
                  child: Text(
                "Carregando dados...",
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on,color: Colors.amber,size: 150.0,),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle: TextStyle(color:Colors.amber,),
                          border: OutlineInputBorder(),
                          prefixText: "R\$",
                        ),
                        style: TextStyle(color: Colors.amber,fontSize: 25.0),

                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Dólares",
                          labelStyle: TextStyle(color:Colors.amber,),
                          border: OutlineInputBorder(),
                          prefixText: "U\$",
                        ),
                        style: TextStyle(color: Colors.amber,fontSize: 25.0),

                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Euros",
                          labelStyle: TextStyle(color:Colors.amber,),
                          border: OutlineInputBorder(),
                          prefixText: "\€",
                        ),
                        style: TextStyle(color: Colors.amber,fontSize: 25.0),

                      ),
                      Divider(),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return jsonDecode(response.body);
}
