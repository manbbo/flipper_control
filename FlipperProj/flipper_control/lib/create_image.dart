import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// this is the CREATE IMAGE CLASS
/// here it specifies how to create a custom image

class CreateImage extends StatelessWidget {
  final BuildContext context;
  final String path;
  final ui.Size size;
  CreateImage (this.context, this.path, this.size);

  @override
  Widget build(context) {
    // TODO: implement build
    return DrawImage(context, path, size);
  }
}

class DrawImage extends StatefulWidget {
  final String path;
  final BuildContext context;
  final ui.Size size;
  DrawImage(this.context, this.path, this.size);

  @override
  _DrawImage createState() => _DrawImage(context, path, size);
}

class _DrawImage extends State<DrawImage> {
  final String path;
  final BuildContext context;
  final ui.Size size;
  _DrawImage(this.context, this.path, this.size);

  ui.Image image;
  bool isImageloaded = false;
  void initState() {
    init(path);
  }

  Future <Null> init(path) async {
    final ByteData data = await rootBundle.load(path);
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      return completer.complete(img);
      });
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return new CustomPaint(
        painter: new PaintImage( image: image, size: size ),
      );
    } else {
      return new Center(child: new Text('loading'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }
}

class PaintImage extends CustomPainter {
  final ui.Image image;
  final ui.Size size;

  PaintImage( { this.image, this.size } );

  @override
  void paint(ui.Canvas canvas, size) {
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
    size = this.size;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}