import 'package:flipper_control/create_image.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// this is the FLIPPER CLASS
/// here you create your flipper layout

class Flipper extends StatelessWidget {
  // This widget is the root of your application.
  final int index;
  Flipper(this.index);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flipper Play',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlipperPage(context, index),
    );
  }
}

class FlipperPage extends StatefulWidget {
  final BuildContext context;
  final int index;
  FlipperPage(this.context, this.index, {Key key}): super (key: key);

  @override
  _FlipperPage createState() => _FlipperPage(context, index);
}



class _FlipperPage extends State<FlipperPage> {
  final int index;
  BuildContext context;
  _FlipperPage(this.context, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(this.context),
          )
      ),
      body: new Stack(
        children: <Widget>[
          new CreateImage(this.context, 'assets/images/board$index.jpg', MediaQuery.of(context).size)
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}