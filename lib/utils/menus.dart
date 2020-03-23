import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenu{
  String _title;
  IconData _icon;
  MaterialColor _color;

  MainMenu(this._title, this._icon, this._color);

  set setTitle(String _title){
    this._title = _title;
  }

  String get title{
    return _title;
  }

  set setIcon(IconData iconData){
    this._icon = iconData;
  }

  IconData get icon{
    return _icon;
  }

  MaterialColor get color{
    return _color;
  }

  set setColor(MaterialColor color){
    this._color = color;
  }

  static List<MainMenu> getMenu(){
    final mainMenu = MainMenu("Take Questionaire", Icons.assignment, Colors
        .blueGrey);
    final mainMenu1 = MainMenu("Talk To NCDC", Icons.phone, Colors
        .orange);

    return [
      mainMenu, mainMenu1
    ];
  }
}