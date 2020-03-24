import 'dart:convert';

import 'package:covid19/utils/menus.dart';
import 'package:covid19/utils/models.dart';
import 'package:covid19/utils/api.dart';
import 'package:covid19/utils/apppreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Questionaire extends StatefulWidget {
  AppPreference _appPreference;

  Questionaire(this._appPreference);

  static void start(BuildContext context, AppPreference _appPreference) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Questionaire(_appPreference)));
    //Navigator.push(context,
    // MaterialPageRoute(builder: (context) => DashboardPage
    // (appPreference)));
  }

  @override
  QuestionairePageState createState() => QuestionairePageState(_appPreference);
}

class QuestionairePageState extends State<Questionaire> {
  AppPreference _appPreference;

  HTTPApi _httpApi;

  DiagnosisResponse _diagnosisResponse;
  QuestionResponse _question;
  List<DiagnosisItem> diagosisItems;
  List<Map<String, String>> answers;
  Color itemColor = Colors.blueGrey;
  List<DiagnosisItem> selectedItems = new List<DiagnosisItem>();
  int selectedItem = -1;

  String _sex;
  int _age;

  QuestionairePageState(this._appPreference);

  @override
  void initState() {
    answers = new List();
    _httpApi = new HTTPApi();
    _loadQuestion();

    super.initState();
  }

  void _loadQuestion(){
    _appPreference.getAge().then((age) {
      _appPreference.getSex().then((sex) {
        this._sex = sex;
        this._age = int.parse(age);
        _httpApi
            .submitDiagnosisQuestion(sex, _age, []).then((response) {
          this._diagnosisResponse =
              DiagnosisResponse.fromJson(json.decode(response.body));
          this._question = _diagnosisResponse.question;
          this.diagosisItems = _question.diagosisItems;

          print("hello: ${_diagnosisResponse.question.text}");
          setState(() {});
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(top: 50),
          height: 70,
          child: Text(
            "Diagnosis "
            "Question",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
      body: _question == null
          ? Utils.showProgress()
          : SafeArea(
              child: new Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white30,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 0,
                      child: Text(
                        "Questionaire",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 40, right: 30,
                        left: 30),
                    width: 100,
                    height: 1,
                    color: Colors.blueGrey,
                  ),
                  Expanded(
                      flex: 0,
                      child: Text(
                    _question.text,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                    textAlign: TextAlign.center,
                  )),
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 30,
                        left: 30),
                    width: 100,
                    height: 1,
                    color: Colors.green,
                  ),
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return  InkWell(
                          onTap: (){
                            if(_diagnosisResponse.shouldStop){
                              final answer = EvidenceRequest.toMap
                                (diagosisItems[index].id,
                                  diagosisItems[index].choiceResponses[0].id);
                              answers.add(answer);
                              if( _age > 0) {
                                _httpApi.submitTriage(_sex, _age, answers).then((response) {
                                  Navigator.pop(context);
                                }).catchError((error){
                                  //Utils.s
                                  print(error);
                                });
                              }
                            }else if(_question.type =="group_multiple"){
                              //Multiple selection
                              diagosisItems[index].isSelected = !diagosisItems[index].isSelected;
                              if(!selectedItems.contains(diagosisItems[index])) {
                                selectedItems.add(diagosisItems[index]);
                              }else{
                                selectedItems.remove(diagosisItems[index]);
                              }
                            }else{
                              //Load nest question
                              _loadQuestion();
                            }

                            print("RESULT: ${selectedItems.length}");
                            setState(() { });

                          },
                          child: new Card(
                              color:  diagosisItems[index].isSelected ?Colors.red: Colors.blueGrey,
                              margin: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              elevation: 5,
                              child: Padding(padding: EdgeInsets.all(20),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex:0,
                                      child: Icon(Icons.question_answer, color: Colors.white70,),
                                    ),
                                    Padding(padding: EdgeInsets.all(10)),
                                    Expanded(
                                        child: Text(diagosisItems[index].name,
                                          style: TextStyle(fontSize: 21,
                                              fontWeight: FontWeight.bold, color:
                                              Colors.white),)),
                                  ],
                                ),)
                          ),
                        );
                      },
                      itemCount: diagosisItems.length,
                    ),
                  ))
                ],
              ),
            )),
    );
  }
}
