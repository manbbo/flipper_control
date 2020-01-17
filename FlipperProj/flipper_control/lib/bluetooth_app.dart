import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:bluetooth/bluetooth.dart';

class BluetoothMgmt extends StatelessWidget {
  final BuildContext context;
  BluetoothMgmt(this.context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BluetoothStateful(this.context);
  }
}

class BluetoothStateful extends StatefulWidget {
  final BuildContext context;
  BluetoothStateful (this.context);

  _BluetoothStateful createState() => _BluetoothStateful(this.context);
}

class _BluetoothStateful extends State<BluetoothStateful> {
  final BuildContext context;
  _BluetoothStateful(this.context);

  FlutterBlue bluetooth = FlutterBlue.instance;

  bool scanDevices() {

// Listen to scan results
    var subscription = bluetooth.scan().listen((scanResult) {
      // do something with scan result
      BluetoothDevice device = scanResult.device;
      print('${device.name} found! rssi: ${scanResult.rssi}');

      //Pinball Play - nome do dispositivo
    });

// Stop scanning
    subscription.cancel();

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //child: ShowDialog(this.context, true)
    );
  }

}