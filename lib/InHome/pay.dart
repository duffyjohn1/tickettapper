import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
//import 'package:url_launcher/url_launcher.dart';

class MyNFC extends StatefulWidget {
  @override
  _MyNFCState createState() => new _MyNFCState();
}

class _MyNFCState extends State<MyNFC> {
  NfcData _nfcData;
  NFCStatus _status;

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
      response = await FlutterNfcReader.read;
    } on PlatformException {
      print('NFC: Scan stopped exception');
    }
    setState(() {
      _nfcData = response;
    });
  }

  Future<void> stopNFC() async {
    NfcData response;

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
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Plugin example app'),
            ),
          body: new SafeArea(
            top: true,
            bottom: true,
            child: new Center(
              child: ListView(
                children: <Widget>[
                  new SizedBox(
                    height: 10.0,
                    ),
                  new Text(
                    '- NFC Status -\n',
                    textAlign: TextAlign.center,
                    ),
                  new Text(
                    _nfcData != null ? 'Status: ${_nfcData.status}' : '',
                    textAlign: TextAlign.center,
                    ),
                  new Text(
                    _nfcData != null ? 'Identifier: ${_nfcData.id}' : '',
                    textAlign: TextAlign.center,
                    ),
                  new Text(
                    _nfcData != null ? 'Content: ${_nfcData.content}' : '',
                    textAlign: TextAlign.center,
                    ),
                  new Text(
                    _nfcData != null ? 'Error: ${_nfcData.error}' : '',
                    textAlign: TextAlign.center,
                    ),
                  new RaisedButton(
                    child: Text('Start NFC'),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      startNFC();
                    },
                    ),
                  new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text('Stop NFC'),
                    onPressed: () {
                      stopNFC();
                    },
                    ),

                ],
                ),
              ),
            )),
      );
  }
}
