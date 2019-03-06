
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tickettapper/login.dart';
import 'stacked_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() =>  _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  get signUp => null;


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
      body: SingleChildScrollView(
        child: Container(
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),

                                  ),
                                labelText: 'Email',

                                ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Valid email required';
                                }
                              },
                              ),
                            const SizedBox(height: 16.0),

                            TextFormField(
                              decoration: const InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),

                                  ),
                                labelText: 'Full Name',
                                ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Full name is required';
                                }
                              },
                              ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                                decoration: const InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),

                                    ),
                                  labelText: 'Password',

                                  ),

                                validator: (String value) {
                                  if (value.trim().isEmpty) {
                                    return 'Password is required';
                                  }
                                }
                                ),

                          ]
                          )
                      )
                ],
                ),
              new SizedBox(
                height: 15.0,
                ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 20.0, top: 10.0),
                      child: GestureDetector(
                        onTap: ()
                        {
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
        ),

      );
  }

  Future<void> signIn() async {
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

}