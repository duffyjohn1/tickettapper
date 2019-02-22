import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';
import 'signup.dart';
import 'google_signIn.dart';
import 'home.dart';

void main() => runApp(TicketTapper());

class TicketTapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicketTapper',
      debugShowCheckedModeBanner: false,
      // Set Raleway as the default app font
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),

      home: WelcomePage(),
    );
  }
}


class WelcomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Sign In With Email",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        handleSignIn();

                        /* This attempts to ensure user can only move forward once signed in

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                                ));
                        }*/
                      },
                    child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(
                            color: Color(0xFFDF513B),
                            borderRadius: new BorderRadius.circular(9.0)),
                        child: new Text("Google",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                      ),
                      ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFFFFCE56),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("New Account",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
