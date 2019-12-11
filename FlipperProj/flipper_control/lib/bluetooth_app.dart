import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    bluetoothConnectionState();
  }

  // We are using async callback for using await
  Future<void> bluetoothConnectionState() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // For knowing when bluetooth is connected and when disconnected
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case FlutterBluetoothSerial.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });

          break;

        case FlutterBluetoothSerial.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;

        default:
          print(state);
          break;
      }
    });

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  GestureDetector createList(int index) {
    return GestureDetector(
        onTap: () {

        },
        child: new Center(
          child: new Container(
            padding: EdgeInsets.all(10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_getDeviceItems()[index].toString())
                //Text(text: _getDeviceItems()[index]);
              ], //
            ),
          ),
        )
    );
  }

  ShowDialog (BuildContext context, bool pressed) {
    if (pressed) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("ESCOLHA SEU DISPOSITIVO"),
          //content: ,
          content: Row(
            children: <Widget>[
              ListView.builder(
                // To be implemented : _getDeviceItems()
                itemBuilder: (_, index) => createList(index),
                itemCount: _getDeviceItems().length,
              )
              //onChanged: (value) => setState(() => ),
              //value: _device,)
            ],
          ),
        );
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ShowDialog(this.context, true)
    );
  }

}