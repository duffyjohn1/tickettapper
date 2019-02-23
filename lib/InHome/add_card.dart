import 'package:flutter/material.dart';
import 'package:tickettapper/InHome/pay.dart';

class StripePay extends StatefulWidget {
  @override
  _StripePayState createState() => new _StripePayState();
}

class _StripePayState extends State<StripePay> {
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0XFF29D091),
        currentIndex: _bottomNavIndex,
        onTap: (int index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: [
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.home)),
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.directions_bus)),
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.message)),
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.all_out))
        ],
      ),
      appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      body: MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text("   New Card   "),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: () {},
        ),
        RaisedButton(
          child: Text("Remove Card"),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: () {},
        )
      ],
    )));
  }
}
