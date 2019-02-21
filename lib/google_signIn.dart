import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:tickettapper/stacked_icons.dart';
import 'home.dart';


// Problem getting google sign in to go to home page while requiring sign in
// Can get it to sign in and go to home but can exit out of sign in and still go to home
// Context builder only works in widget build but then handle sign in won't work from main

// Shows fix https://medium.com/flutterpub/flutter-auth-with-google-f3c3aa0d0ccc

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
  );

/*
class GoogleLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Future<void> handleSignIn() async {
      try {
        await _googleSignIn.signIn();
        Navigator.push(
            context, MaterialPageRoute(
          builder: (context) => HomePage(),
          ));
      } catch (error) {
        print(error);
      }
    }

    void GoogleSignIn () {
      handleSignIn();
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.orange, //or set color with: Color(0xFF0000FF)
      ));
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor:Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      resizeToAvoidBottomPadding: false,

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
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'Gmail Address'),
                ),
              ),
            new SizedBox(
              height: 15.0,
              ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                obscureText: true,
                decoration: new InputDecoration(labelText: 'Password'),
                ),
              ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomePage()
                            ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Login",
                                              style: new TextStyle(
                                                  fontSize: 20.0, color: Colors.white))),
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 20.0, top: 10.0),
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: new Text("Forgot Password?",
                                            style: new TextStyle(
                                                fontSize: 17.0, color: Color(0xFF18D191)))),
                    ),
                  )
              ],
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: new Text("Create A New Account ",style: new TextStyle(
                        fontSize: 17.0, color: Color(0xFF18D191),fontWeight: FontWeight.bold)),
                    ),
                ],
                ),
              )
          ],
          ),
        ),
      );
  }
}

*/

/*
initLogin() {
  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
    if (account != null) {
      // user logged
    } else {
      // user NOT logged
    }
  });
  _googleSignIn.signInSilently().whenComplete(() => dismissLoading());
}
*/


Future<void> handleSignIn() async {
  try {
    await _googleSignIn.signIn();
    MaterialPageRoute(
      builder: (context) => HomePage(),
      );
  } catch (error) {
    print(error);
  }
}







