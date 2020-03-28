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
        primarySwatch: Colors.blueGrey,
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

  String _age ="1";

  String _radioValue;

  String choice;

  String alreadyLogIn;

  AppPreference _appPreference;

  _MyHomePageState(){
    this._appPreference = AppPreference();
  }

  @override
  void initState() {
    alreadyLogIn ='';
    _appPreference.getUsername().then((data){
      alreadyLogIn = data;
      if(data != null) {
        DashboardPage.start(context, _appPreference);
      }
      setState(() {});
    });
    super.initState();
  }



  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Male':
          choice = value;
          break;
        case 'Female':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: alreadyLogIn !=null ? Container(): Container(
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
                          )
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      new Flexible(
                          flex:0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              onChanged: (text){
                                setState(() {
                                  this._age = text;
                                  //print("age $_age");
                                });
                              },
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.cake),
                                  hintText: "What's your age?"),
                            ),
                          )
                      ),
                      Padding(padding: EdgeInsets.only(left: 20, bottom: 20)),
                      new Flexible(
                          flex:0,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 20)),
                                Text("Sex:  "),
                                Radio(value: 'Male', groupValue: _radioValue,
                                    onChanged: radioButtonChanges),
                                Text("Male"),
                                Padding(padding: EdgeInsets.only(right: 20)),
                                Radio(value: 'Female', groupValue: _radioValue,
                                    onChanged: radioButtonChanges),
                                Text("Female"),

                              ],
                            )
                          )
                      ),
                      Flexible(
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                            child: RaisedButton(
                              onPressed: (_userName == null || _userName.trim().length
                                  <=2) || choice == null || int.parse(_age) <
                                  3 ? null :
                                  () {
                                    _appPreference.setSex(choice);
                                    _appPreference.setAge(_age);
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
                          )
                      )
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
