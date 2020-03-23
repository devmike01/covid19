import 'package:covid19/utils/apppreference.dart';
import 'package:flutter/material.dart';

import 'main/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _userName;

  String alreadyLogIn;

  AppPreference _appPreference;

  _MyHomePageState(){
    this._appPreference = AppPreference();
  }

  @override
  void initState() {
    _appPreference.getUsername().then((data){
      alreadyLogIn = data;
      if(data != null) {
        DashboardPage.start(context, _appPreference);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  new Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 30),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Flexible(
                    child: Image.asset("assets/images/female_doc_ic.jpg"),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Flexible(
                        flex:0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              maxLines: 1,
                              onChanged: (text){
                                setState(() {
                                  this._userName = text;
                                });
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person_outline),
                                  hintText: 'Enter your name'),
                            ),
                          )),
                      Flexible(
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                            child: RaisedButton(
                              onPressed: (_userName == null || _userName.trim().length
                                  <=2) ? null :  () {
                                _appPreference.setUsername(_userName.trim());
                                DashboardPage.start(context, _appPreference);
                              },
                              color: Colors.green,
                              child: Padding(
                                padding: EdgeInsets.all(17),
                                child: Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
                  //new Flexible(child: Image.asset("assets/images/doctor_ic.jpg"),)
                ],
              ),
            ],
          )
      ),
    );
  }


}
