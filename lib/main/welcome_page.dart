import 'dart:io';

import 'package:covid19/utils/apppreference.dart';
import 'package:covid19/utils/menus.dart';
import 'package:covid19/utils/myhtmlparser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
//import 'package:html/parser.dart' as parser;

class DashboardPage extends StatefulWidget {
  final AppPreference appPreference;

  DashboardPage(this.appPreference);

  static void start(BuildContext context, AppPreference appPreference) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => DashboardPage(appPreference)),
      (bb) => false,
    );
    //Navigator.push(context,
    // MaterialPageRoute(builder: (context) => DashboardPage
    // (appPreference)));
  }

  @override
  DashboardPageState createState() => DashboardPageState(appPreference);
}

class DashboardPageState extends State<DashboardPage> {
  final AppPreference _appPreference;
  String _username;
  DashboardPageState(this._appPreference);
  List<String> count = new List();
  final titles = new List();

  @override
  void initState() {
    _appPreference.getUsername().then((data) {
      this._username = data;
    });

    http.get("http://covid19.ncdc.gov.ng/").then((response) {
      //final pResponse = parser.parse(response.body);
      //final nme = pResponse.body.children.first;
      var doc = parse(response.body);

      //class="col-md-5 col-sm-5 col-xs-12"
      var elements = doc.querySelector("div.col-md-5").querySelectorAll("td");

      elements.forEach((el) {
        var regex = RegExp("\\d");
        String result = el.text;
        if (regex.hasMatch(result)) {
          count.add(result.trim());
        } else {
          titles.add(result);
        }
        setState(() {});
        // }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _textSize = 10;

    final boldWeight = FontWeight.bold;

    return titles.isEmpty
        ? new Container(
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            color: Colors.white,
            child: CircularProgressIndicator(),
          )
        : new Scaffold(
            extendBody: true,
            resizeToAvoidBottomPadding: false,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.only(left: 22, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(child: initGreetings(boldWeight, _textSize)),
                        Expanded(
                          flex: 0,
                          child: new Container(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.settings),
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 120,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: titles.length < 3
                        ? null
                        : Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              padding: EdgeInsets.all(18),
                              alignment: AlignmentDirectional.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset("assets/images/siren_ic.png"),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Expanded(
                                        flex: 0,
                                        child: Text(
                                          "${titles[0]}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${count[0].trim()}",
                                          style: TextStyle(fontSize: 23),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: Colors.black45,
                                  ),
                                  new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/total_discharge_ic.png",
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      Expanded(
                                        flex: 0,
                                        child: Text(
                                          "Total ${titles[1]}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${count[1].trim()}",
                                          style: TextStyle(fontSize: 23),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        "One Click "
                        "Diagonistic "
                        "Questionaire",
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  width: 70,
                  height: 1,
                  color: Colors.red,
                  margin: EdgeInsets.only(left: 20, bottom: 20),
                ),
                Expanded(
                  flex: 0,
                  child: new Container(
                    margin: EdgeInsets.only(left: 2, right: 2),
                    height: 130,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(2, (index) {
                        return Container(
                          child: Card(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Icon(
                                    MainMenu.getMenu()[index].icon,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Expanded(
                                      child: Text(
                                    MainMenu.getMenu()[index].title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            color: MainMenu.getMenu()[index].color,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        "Statistics By State",
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  width: 50,
                  height: 1,
                  color: Colors.blue,
                  margin: EdgeInsets.only(left: 20, bottom: 10),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                      itemBuilder: (context, index) => index < 3
                          ? Container()
                          : Card(
                              color: int.parse(count[index]) > 0
                                  ? Colors.red
                                  : Colors.blueGrey,
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 0,
                                      child: Icon(
                                        Icons.local_hospital,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: Colors.white,
                                      height: 30,
                                      margin:
                                          EdgeInsets.only(left: 16, right: 16),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            titles[index],
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(padding: EdgeInsets.all(2)),
                                          Text(
                                              "Infected persons: ${count[index].trim()}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white70))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      itemCount: titles.length,
                      shrinkWrap: true,
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget initGreetings(FontWeight boldWeight, double _textSize) {
    return new Container(
      width: double.maxFinite,
      height: 60,
      child: _username == null
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Hey, $_username",
                    maxLines: 1,
                    softWrap: true,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                  ),
                  flex: 0,
                ),
                Padding(padding: EdgeInsets.all(2)),
                Expanded(
                    child: Text(
                  "Have you washed yours hands today?",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )),
              ],
            ),
    );
  }
}
