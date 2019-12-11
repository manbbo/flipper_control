import 'package:flipper_control/bluetooth_app.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// this is the FLIPPER CLASS
/// here you create your flipper layout

class Flipper extends StatelessWidget {
  // This widget is the root of your application.
  final int index;
  final BuildContext context;
  Flipper(this.context, this.index);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flipper Play',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlipperPage(this.context, index),
    );
  }
}

class FlipperPage extends StatefulWidget {
  final BuildContext context;
  final int index;
  FlipperPage(this.context, this.index, {Key key}): super (key: key);

  @override
  _FlipperPage createState() => _FlipperPage(this.context, index);
}

class Button extends StatelessWidget {
  final int index;
  final double vertical, horizontal;
  Button (this.index, this.vertical, this.horizontal);

  var turnOn = ['A', 'B', 'C', 'D'];
  var turnOff = ['a', 'b', 'c', 'd'];

  String sendCommand(int index, bool state) {
    if (state) {
      print(turnOn[index-1]);
      return turnOn[index-1];
    } else {
      print(turnOff[index-1]);
      return turnOff[index-1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () =>
        sendCommand(index, true),
      onLongPressUp: () =>
          sendCommand(index, false),
      onTap: () => BluetoothMgmt(context),
      child: new Padding(
        padding: EdgeInsets.symmetric(vertical: this.vertical, horizontal: this.horizontal),
        child: new Image.asset('assets/images/button$index.png', scale: 5,),
      ),
    );
  }
}

class _FlipperPage extends State<FlipperPage> {
  final int index;
  final BuildContext context;

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
          new Image.asset('assets/images/board$index.jpg'),
          new Container (
            child: new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Button(1, 30, 0), // Start Button
                          new Button(2, 30, 0) // Shoot Ball
                        ],
                      ),
                    ),
                    new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Button(3, 120, 40), // Left Flipper Button
                          new Button(4, 120, 40) // Right Flipper Button
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          //GestureDetector(
            // it is a TEST ONLY WIDGET
            //onTap: () => BluetoothMgmt(context),
            //child: new Image.asset('assets/images/button1.png'),
          //)
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}