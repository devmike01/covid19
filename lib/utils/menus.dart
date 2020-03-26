import 'package:covid19/main/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: isReload ? Utils.showProgress() : Column(
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
                  style: TextStyle(fontSize: 16, color: Colors.red,),
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
            flex: 0,
              child: RaisedButton(
            child: Text("Try Again", style: TextStyle(color: Colors.white),),
            onPressed: () {
              isReload = true;
              widget.refresh();

            },color: Colors.blueGrey,
          ))
        ],
      ),
    );
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

  static bool isAState(String title){
    return states.contains(title);
  }

  static bool isOthers(String title){
    return ["Total Confirmed cases",
      "Active cases", "Discharged", "Death"].contains(title);
  }
}
