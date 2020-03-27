import 'package:covid19/main/welcome_page.dart';
import 'package:covid19/utils/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api.dart';

class MainMenu {
  String _title;
  IconData _icon;
  MaterialColor _color;

  MainMenu(this._title, this._icon, this._color);

  set setTitle(String _title) {
    this._title = _title;
  }

  String get title {
    return _title;
  }

  set setIcon(IconData iconData) {
    this._icon = iconData;
  }

  IconData get icon {
    return _icon;
  }

  MaterialColor get color {
    return _color;
  }

  set setColor(MaterialColor color) {
    this._color = color;
  }

  static List<MainMenu> getMenu() {
    final mainMenu =
        MainMenu("Take Questionaire", Icons.assignment, Colors.blueGrey);
    final mainMenu1 = MainMenu("Talk To NCDC", Icons.phone, Colors.orange);

    return [mainMenu, mainMenu1];
  }
}

class Utils {
  static bool isReload = false;

  static String _imgAsset = 'assets/images/';

  static Widget showProgress() {
    return new Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      color: Colors.white,
      child: CircularProgressIndicator(),
    );
  }

  static Widget showFailure(DashboardPageState widget) {
    isReload = false;
    return new Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      color: Colors.white,
      child: isReload
          ? Utils.showProgress()
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                      width: double.maxFinite,
                      child: Text(
                        "An error has occurred. Please try againt",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Expanded(
                    flex: 0,
                    child: RaisedButton(
                      child: Text(
                        "Try Again",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        isReload = true;
                        widget.refresh();
                      },
                      color: Colors.blueGrey,
                    ))
              ],
            ),
    );
  }

  static Widget showAlert(){
    return AlertDialog(
      title: Text('Notice'),
      content: Text("I'm not a doctor, I'm just a Software Engineer. However,"
          " the questionaire is based strictly on WHO guidelines"),
      actions: <Widget>[
        FlatButton(onPressed: (){
          
        }, child: Text('Got it', style: TextStyle(),))
      ],
    );
  }

  static void showResultOfInterview(
      BuildContext context, TriageResponse response) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:
      Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: Container(
                        padding: EdgeInsets.only(left: 17, right: 17),
                        margin: EdgeInsets.only(top: 80),
                        child: new Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                           Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Text(
                                 'Diagnostic',
                                 style: TextStyle(
                                     fontSize: 27,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.blueGrey),
                               ),
                               Padding(padding: EdgeInsets.all(6)),
                               //response.label
                               Text(
                                 response.label,
                                 style: TextStyle(
                                     fontSize: 17, fontWeight: FontWeight
                                     .bold, color: Colors.black45),
                                 textAlign: TextAlign.center,
                               ),
                               Padding(padding: EdgeInsets.all(4)),
                               Text(
                                 response.description,
                                 style: TextStyle(
                                     fontSize: 17, fontWeight: FontWeight
                                     .normal, color: Colors.black87),
                                 textAlign: TextAlign.center,
                               ),
                             ],
                           ),
                            Padding(padding: EdgeInsets.all(20),),
                            RaisedButton(onPressed: (){
                              launch(HTTPApi.NCDC_PHONE);
                            }, child: Padding(padding: EdgeInsets.all(11),
                              child: Text('Call Now', style: TextStyle
                              (color: Colors.white, fontWeight: FontWeight
                                .normal, fontSize: 20),
                            ),),
                              color: Colors.deepOrange,
                            ),

                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                    Container(
                      height: double.maxFinite,
                      width: 110,
                      alignment: Alignment.topCenter,
                      child: Card(
                        margin: EdgeInsets.only(bottom: 100),
                        child: new Container(
                          child: Image.asset(getImage(response.triageLevel)),
                          width: 100,
                          height: 100,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  static String getImage(String triageLevel) {
    return {
      'no_risk': '${_imgAsset}no_risk_ic.png',
      'self_monitoring': '${_imgAsset}self_monitoring_ic.png',
      'quarantine': '${_imgAsset}self_monitoring_ic.png',
      'isolation_call': '${_imgAsset}iso_call_ic.png',
      'isolation_ambulance': '${_imgAsset}iso_call_ic.png'
    }[triageLevel];
  }

  static var states = [
    "Abia",
    "Adamawa",
    "Anambra",
    "Bayelsa",
    "Borno",
    "Delta",
    "Enugu",
    "Ekiti",
    "Abuja FCT",
    "Imo",
    "Katsina",
    "Kogi",
    "Lagos",
    "Niger",
    "Ondo",
    "Oyo",
    "Rivers",
    "Taraba",
    "Zamfara",
    "Kaduna",
    "Akwa Ibom",
    "Bauchi",
    "Benue",
    "Cross River",
    "Ebonyi",
    "Edo",
    "Gombe",
    "Jigawa",
    "Kano",
    "Kebbi",
    "Kwara",
    "Nasarawa",
    "Ogun",
    "Osun",
    "Plateau",
    "Sokoto",
    "Yobe",
  ];

  static bool isAState(String title) {
    return states.contains(title);
  }

  static bool isOthers(String title) {
    return ["Total Confirmed cases", "Active cases", "Discharged", "Death"]
        .contains(title);
  }
}
