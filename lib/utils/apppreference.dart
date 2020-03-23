import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{

  Future<SharedPreferences> _sPrefFuture;

  AppPreference(){
    _sPrefFuture = SharedPreferences.getInstance();
  }

  setUsername(String name)  {
    _sPrefFuture.then((spref){
      spref.setString('username', name);
      print("DATA: $name");
    });
  }

  Future<String> getUsername() async{
   // String name;
     return Future<String>.value(await _sPrefFuture.then((pref) =>pref.getString
      ('username')));
  }
}