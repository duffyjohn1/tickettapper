import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex=0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0XFF29D091),
        currentIndex: _bottomNavIndex,
        onTap: (int index){
          setState((){
            _bottomNavIndex = index;

          });
        },

        items: [
          new BottomNavigationBarItem(
              title: new Text(''),
              icon: new Icon(Icons.home)
              ),
          new BottomNavigationBarItem(
              title: new Text(''),
              icon: new Icon(Icons.directions_bus)
              ),
          new BottomNavigationBarItem(
              title: new Text(''),
              icon: new Icon(Icons.message)
              ),
          new BottomNavigationBarItem(
              title: new Text(''),
              icon: new Icon(Icons.all_out)
              )

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
    return new ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Container(
              child: new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Text(
                        "Ticket Tapper",
                        style: new TextStyle(
                          fontSize: 30.0,
                          ),
                        textAlign: TextAlign.left,
                        ),
                    ],
                    ),
                  new SizedBox(
                    height: 20.0,
                    ),
                  Row(
                      children: <Widget>[

                        new SizedBox(
                          height:10.0,
                          ),

                        new Expanded(
                            child: new Container(
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    color: Color(0xFFDF513B)
                                    ),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.euro_symbol,
                                      color: Colors.black,
                                      ),
                                    new Text("Pay",
                                                 style:new TextStyle(color: Colors.white))
                                  ],
                                  )
                                )
                            )
                      ]),
                  new SizedBox(
                    height:20.0,
                    ),
                  Row(
                      children: <Widget>[

                        new SizedBox(
                          height: 10.0,
                          ),

                        new Expanded(
                            child: new Container(
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    color: Color(0xFF18D191)
                                    ),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.map,
                                      color: Colors.black,
                                      ),
                                    new Text("Plan Route",
                                                 style:new TextStyle(color: Colors.white))
                                  ],
                                  )
                                )
                            )
                      ]
                      ),
                  new SizedBox(
                    height: 20.0,
                    ),
                  Row(
                      children: <Widget>[

                        new SizedBox(
                          height: 10.0,
                          ),

                        new Expanded(
                            child: new Container(
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(20.0),
                                    color: Color(0xFFFFCE56)
                                    ),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.directions_bus,
                                      color: Colors.black,
                                      ),
                                    new Text("Timetable",
                                                 style:new TextStyle(color: Colors.white))
                                  ],
                                  )
                                )
                            )
                      ]
                      ),
                  new SizedBox(
                    height: 15.0,
                    ),
                  Row(
                      children: <Widget>[
                        new Expanded(
                            child: new Text("Dublin Attractions",
                                                style: new TextStyle(fontSize: 18.0))),
                        new Expanded(
                          child: new Text(
                            "Dublin, Ireland",
                            style: new TextStyle(color: Color(0XFF2BD093)),
                            textAlign: TextAlign.end,
                            ),

                          )
                      ]
                      ),
                  new SizedBox(
                    height: 10.0,
                    ),
                  Row(
                    children: <Widget>[
                      new Expanded(
                        child: Container(
                          height: 150.0,
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    image: new DecorationImage(
                                        image: new NetworkImage(
                                            'https://cdn.getyourguide.com/img/tour_img-472363-146.jpg'),
                                        fit: BoxFit.cover)),
                                ),
                              new Text(
                                "Guiness Storehouse",
                                style: new TextStyle(fontSize: 16.0),
                                textAlign: TextAlign.center,
                                )
                            ],
                            ),
                          ),
                        ),
                      new SizedBox(
                        width: 5.0,
                        ),
                      new Expanded(
                        child: Container(
                          height: 150.0,
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    image: new DecorationImage(
                                        image: new NetworkImage(
                                            'https://cache-graphicslib.viator.com/graphicslib/page-images/742x525/135095_Dublin_DublinCastle_683.jpg'),
                                        fit: BoxFit.cover)),
                                ),
                              new Text("Dublin Castle",
                                           style: new TextStyle(fontSize: 16.0),
                                           textAlign: TextAlign.center)
                            ],
                            ),
                          ),
                        ),
                      new SizedBox(
                        width: 5.0,
                        ),
                      new Expanded(
                        child: Container(
                          height: 150.0,
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    image: new DecorationImage(
                                        image: new NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Long_Room_Interior%2C_Trinity_College_Dublin%2C_Ireland_-_Diliff.jpg/1200px-Long_Room_Interior%2C_Trinity_College_Dublin%2C_Ireland_-_Diliff.jpg'),
                                        fit: BoxFit.cover)),
                                ),
                              new Text('Trinity College Library',
                                           style: new TextStyle(fontSize: 16.0),
                                           textAlign: TextAlign.center)
                            ],
                            ),
                          ),
                        )
                    ],
                    ),



                ],
                )),
          )
      ],
      );
  }
}
