import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:tickettapper/InHome/qr_gen.dart';
import 'dart:io';


class MyNFC extends StatefulWidget {
  @override
  _MyNFCState createState() => new _MyNFCState();
}

class _MyNFCState extends State<MyNFC> {
  NfcData _nfcData;
  NFCStatus _status;
  var x = 'False';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startNFC() async {
    NfcData response;

    setState(() {
      _nfcData = NfcData();
      _nfcData.status = NFCStatus.reading;
    });

    print('NFC: Scan started');

    try {
      print('NFC: Scan readed NFC tag');
      response = (await FlutterNfcReader.read) as NfcData;
    } on PlatformException {
      print('NFC: Scan stopped exception');
    }
    setState(() {
      _nfcData = response;
    });
  }

  Future<void> stopNFC() async {
    NfcData response;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GenerateScreen()),
      );

    try {
      print('NFC: Stop scan by user');
      response = await FlutterNfcReader.stop;
    } on PlatformException {
      print('NFC: Stop scan exception');
      response = NfcData(
        id: '',
        content: '',
        error: 'NFC scan stop exception',
        statusMapper: '',
        );
      response.status = NFCStatus.error;
    }

    setState(() {
      _nfcData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Colors.white),
            ),
          body: new SafeArea(
            top: true,
            bottom: true,
            child: new Center(
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Text(
                        "Ticket Tapper",
                        style: new TextStyle(
                          fontSize: 30.0,
                          ),
                        textAlign: TextAlign.center,
                        ),
                    ],
                    ),
            new SizedBox(
              height: 15.0,
            ),
            new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(50.0),
                      color: Color(0xFF18D191)),
                  child: new Icon(
                    Icons.local_offer,
                    color: Colors.black,
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(right: 50.0, top: 50.0),
                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(50.0),
                      color: Color(0xFFFC6A7F)),
                  child: new Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 30.0, top: 50.0),
                  height: 60.0,
                  width: 60.0,
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

                  new SizedBox(
                    height: 200.0,
                    ),

                  new RaisedButton(

                      child: Text('Start NFC'),
                      textColor: Colors.white,
                      color: Colors.red,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(150.0)),
                      onPressed: () {
                        startNFC();
                        //sleep(const Duration(seconds:5));
                        if (_nfcData != null) {
                          stopNFC();
                        }
                      }
                      ),
                ],
                ),
              ),
            )),
      );
  }

}

