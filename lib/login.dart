import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'stacked_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => new _LoginPageState();
}
class  _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.orange, //or set color with: Color(0xFF0000FF)
      ));

    return new Scaffold(
        appBar: new AppBar(
            backgroundColor:Colors.transparent,
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
                Expanded(
                    child: new Form(
                        key: _formKey,
                        child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                                  child: new TextFormField(
                                    decoration: const InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),

                                        ),
                                      labelText: 'Email',
                                      ),
                                    validator: (input) {
                                      if(input.isEmpty){
                                        return 'Provide an email';
                                      }
                                    },
                                    onSaved: (input) => _email = input,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: 10.0,
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                      ),
                                    labelText: 'Password',
                                    ),
                                  validator: (input) {
                                    if(input.length < 6){
                                      return 'Password has to be > 6 characthers';
                                    }
                                  },
                                  onSaved: (input) => _password = input,
                                  obscureText: true,
                                  ),
                                )
                            ]
                            )
                        )
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
                          onTap: signIn
                          /*{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => signIn,
                                  ));
                          }*/,
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
                      ),


                  ],
                  ),
              ]
              ),
          )
        );
  }

  void signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      catch(e){
        print("User not in Database");
      }
    }
  }

}