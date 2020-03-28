import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{

  Future<SharedPreferences> _sPrefFuture;

  AppPreference(){
    _sPrefFuture = SharedPreferences.getInstance();
  }

  setUsername(String name)  {
    _sPrefFuture.then((spref){
      spref.setString('username', name);

    });
  }


  void cacheNcdc(String data){
    _sPrefFuture.then((spref){
      spref.setString('NCDC_DATA', data);
    });
  }

  Future<String> getCacheNcdc() async{
    return Future<String>.value(await _sPrefFuture.then((pref) =>pref.getString
      ('NCDC_DATA')));
  }


  setAge(String age)  {
    _sPrefFuture.then((spref){
      spref.setString('age', age);
    });
  }


  setSex(String sex)  {
    _sPrefFuture.then((spref){
      spref.setString('sex', sex);
    });
  }

  Future<String> getUsername() async{
   // String name;
     return Future<String>.value(await _sPrefFuture.then((pref) =>pref.getString
      ('username')));
  }

  Future<String> getAge() async{
    return Future<String>.value(await _sPrefFuture.then((pref) =>pref.getString
      ('age')));
  }

  Future<String> getSex() async{
    return Future<String>.value(await _sPrefFuture.then((pref) =>pref.getString
      ('sex')));
  }
}