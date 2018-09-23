import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url ="https://nikdemo.com/wallpaper/apidemo.php";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{

    var response = await http.get(
      // Encode URl
      Uri.encodeFull(url),
      // only accept json response
      headers: {"Accept":"Application/json"}
    );

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['Category'];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Json via HTTP Get"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context,int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Image.network("https://www.nikdemo.com/wallpaper/"+data[index]['cat_photo']),
                          new Text(data[index]['cat_name']),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

