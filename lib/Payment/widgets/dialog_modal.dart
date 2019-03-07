
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tickettapper/InHome/qr_gen.dart';

Future<void> showAlertDialog(
    {BuildContext context, String title, String description}) =>
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 90.0,
              ),
            ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.push(context,
                                     MaterialPageRoute(
                                         builder: (context) => GenerateScreen()),);
                  },
                ),
              ],
            ));
