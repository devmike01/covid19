import 'package:covid19/utils/api.dart';
import 'package:covid19/utils/apppreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Questionaire extends StatefulWidget{

  AppPreference _appPreference;

  Questionaire(this._appPreference);

  static void start(BuildContext context, AppPreference _appPreference) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Questionaire(_appPreference))
    );
    //Navigator.push(context,
    // MaterialPageRoute(builder: (context) => DashboardPage
    // (appPreference)));
  }

  @override
  QuestionairePageState createState() => QuestionairePageState(_appPreference);

}

class QuestionairePageState extends State<Questionaire>{


  AppPreference _appPreference;

  HTTPApi _httpApi;

  QuestionairePageState(this._appPreference);
  
  @override
  void initState() {
    _httpApi = new HTTPApi();
    _appPreference.getAge().asStream()
        .asyncMap((map) => _appPreference.getSex())
        .listen((data) {
          print("data: $data");
    }, onError: (error){
          print("ERRORROROOR $error");
    }, onDone: (){

      print("ERRORROROOR DOOOOOONE");
    });

    _httpApi.submitDiagnosisQuestion("", "", []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Container(margin:EdgeInsets.only(top: 50), height: 70, child:
        Text
          ("Diagnosis "
            "Question",
          style:
        TextStyle(fontWeight:
        FontWeight.bold, fontSize: 17,),
        ),),
      ),
      body: SafeArea(child: new Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Expanded(child: Text(""))
          ],
        ),
      )),
    );
  }

}