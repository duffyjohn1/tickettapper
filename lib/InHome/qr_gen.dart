import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SafeArea(
            top: true,
            bottom: true,
            child: new Center(
                child: ListView(children: <Widget>[
              new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFF18D191)),
                    child: new Icon(
                      Icons.euro_symbol,
                      color: Colors.black,
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(right: 250.0, top: 50.0),
                    height: 80.0,
                    width: 80.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFFFC6A7F)),
                    child: new Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 250.0, top: 50.0),
                    height: 80.0,
                    width: 80.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFFFFCE56)),
                    child: new Icon(
                      Icons.directions_bus,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
                    child: new Text(
                      "Ticket Tapper",
                      style: new TextStyle(fontSize: 30.0),
                    ),
                  )
                ],
              ),
            ]))));
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Text("Valid Ticket"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.40 * bodyHeight,
                  onError: (ex) {
                    print("[QR] ERROR - $ex");
                    setState(() {
                      _inputErrorText =
                          "Error! Maybe your input value is too long?";
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
