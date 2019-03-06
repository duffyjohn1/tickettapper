import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:tickettapper/InHome/qr_gen.dart';
import 'dart:io';

import 'package:tickettapper/Payment/Pay_main.dart';
import 'package:tickettapper/Payment/widgets/buy_sheet.dart';


class MyNFC extends StatefulWidget {
  @override
  MyNFCState createState() => new MyNFCState();
}

class MyNFCState extends State<MyNFC> {
  NfcData nfcData;
  NFCStatus _status;
  var x = 'False';

  //get showOrderSheet => BuySheetState().showOrderSheet();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startNFC() async {
    NfcData response;

    setState(() {
      nfcData = NfcData();
      nfcData.status = NFCStatus.reading;
    });

    print('NFC: Scan started');

    try {
      print('NFC: Scan readed NFC tag');
      response = (await FlutterNfcReader.read) as NfcData;
    } on PlatformException {
      print('NFC: Scan stopped exception');
    }
    setState(() {
      nfcData = response;
    });
    if (nfcData != null) {
      stopNFC();
    }
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
      nfcData = response;
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
                  new SizedBox(
                    height: 20.0,
                    ),

                  new RaisedButton(

                      child: Text('Start NFC'),
                      textColor: Colors.white,
                      color: Colors.black,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(200.0)),
                      onPressed: () {
                        //BuySheetState().showOrderSheet();
                        startNFC();
                        //

                      }
                      ),
                ],
                ),
              ),
            )),
      );
  }

}
