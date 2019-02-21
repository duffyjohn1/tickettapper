// Should add name and contact details

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tickettapper/login.dart';
import 'stacked_icons.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() =>  _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.orange, //or set color with: Color(0xFF0000FF)
      ));

    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      body: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new StakedIcons(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: new Text(
                    "Ticket Tapper",
                    style: new TextStyle(fontSize: 30.0),
                    ),
                  )
              ],
              ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: new Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: new TextFormField(
                              decoration:
                              new InputDecoration(labelText: 'Email'),
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Provide an email';
                                }
                              },
                              onSaved: (input) => _email = input,
                              ),
                            ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: TextFormField(
                                decoration:
                                new InputDecoration(labelText: 'Password'),
                                validator: (input) {
                                  if (input.length < 6) {
                                    return 'Password has to be > 6 characthers';
                                  }
                                },
                                onSaved: (input) => _password = input,
                                obscureText: true,
                                )
                              )
                        ]))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 250.0),
                    child: GestureDetector(
                     // onTap: signUp,
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Register",
                                              style: new TextStyle(
                                                  fontSize: 20.0, color: Colors.white))),
                      ),
                    ),
                  ),
              ],
              ),
          ],
          ),
        ),
      );
  }
/*
  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print("User not in Database");
      }
    }
  }
  */
}