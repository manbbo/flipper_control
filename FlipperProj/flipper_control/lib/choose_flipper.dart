import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flipper.dart';

/// this is the Chooser Flipper
/// here you can see all available flippers

class ChooseFlipper extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flipper Play',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  List<String> flippers = ['Cavaleiro Negro', 'Startrek', 'Perdidos no Espaco', 'XXX'];

  GestureDetector createList(int index) {
    int boardIndex = index + 1;
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Flipper(context, boardIndex)));
        },
        child: new Center(
          child: new Container(
            padding: EdgeInsets.all(20),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset('assets/images/board$boardIndex.jpg', scale: 2.2,),
                  new RichText(text: TextSpan( text: flippers[index], style: TextStyle(fontSize: 20,
                      color: Colors.white)),)
                ],
              )
            ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('ESCOLHA SEU FLIPPER'),
        backgroundColor: Colors.black,
      ),
      body: new Container(
        child: ListView.builder (
          shrinkWrap: true,
          itemBuilder: (_, int index) => createList(index),
          itemCount: flippers.length,
          scrollDirection: Axis.horizontal,
          addAutomaticKeepAlives: false,
        ),
        color: Colors.black,
      ),
    );
  }
}
