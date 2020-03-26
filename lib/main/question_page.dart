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
  String currentCancer;
  //List<DiagnosisItem> selectedItems = new List<DiagnosisItem>();
  int selectedItem = -1;
  List<EvidenceRequest> _answerJson = new List();
  String _anserValue;
  String _choice;
  int _value =1;
  Map<String, dynamic> selectedMap;
  int _age;
  List<int> selectedPoses;
  List<ChoiceResponse> _selectedChoices;
  //int selectedPos =0;

  QuestionairePageState(this._appPreference);

  @override
  void initState() {
    answers = new List();
    selectedMap = new Map();
    selectedPoses = new List();

    _httpApi = new HTTPApi();

    _anserValue ="Yes";
    _loadQuestion([]);

    super.initState();
  }

  void _loadQuestion(List<EvidenceRequest> evidences){
    _appPreference.getAge().then((age) {
      _appPreference.getSex().then((sex) {
        this._age = int.parse(age);
        _httpApi
            .submitDiagnosisQuestion(sex, _age, evidences).then((response) {
          setState(() {

            this._diagnosisResponse =
                DiagnosisResponse.fromJson(json.decode(response.body));
            this._question = _diagnosisResponse.question;
            this.diagosisItems = _question.diagosisItems;

            print("QUUUESTION: ${_question.text}");
            _selectedChoices = List<ChoiceResponse>.generate(_question.diagosisItems
                    .length, (index) =>
            new ChoiceResponse());

          });
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        actions: <Widget>[
          Expanded(child:
          FlatButton(onPressed: (){
            //Move to next question

          }, child: new Text("Skip", style: TextStyle(
            color: Colors.white,
          ),)), flex: 0,)
        ],
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
                        _answerJson.clear();
                        return Container(
                          width: double.maxFinite,
                          height: 80,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(flex: 0, child: Text(_question
                                  .diagosisItems[index].name)),
                              Expanded(flex: 0, child: getAnswerTile(index))
                            ],
                          ),
                        );
                      },
                      itemCount: diagosisItems.length,
                    ),
                  )),

                ],
              ),
            )),
    );
  }

  void onAnswerValueChanged(String value){
    print("FIND_VALUE: $value");
    setState(() {
      this._anserValue = value;
      switch(value){
        case 'No':
          _choice = value;
          break;
        case 'Yes':
          _choice = value;
          break;
      }

      debugPrint("CHOICE $_choice");
    });
  }

  Widget getAnswerTile(int pos) {
    final item = _question.diagosisItems[pos];
    final choices = item.choiceResponses;
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: choices.map((e) {
          return Padding(
            padding: EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(e.getLabel(), style: TextStyle(color:
              _selectedChoices[pos] == e? Colors.white : Colors.black87 ),),
              selectedColor: Colors.blueGrey, // The background color for selected chips
              selected: _selectedChoices[pos] == e,
              onSelected: (bool selected) {
                // Is this cip selected?
                if (selected) {
                  setState(() => _selectedChoices[pos] = e);
                }
              },
            ),
          );
        }).toList());
  }

}
