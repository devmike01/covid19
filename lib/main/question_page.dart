import 'dart:convert';

import 'package:covid19/utils/menus.dart';
import 'package:covid19/utils/models.dart';
import 'package:covid19/utils/api.dart';
import 'package:covid19/utils/apppreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  int _age;
  List<int> selectedPoses;
  List<ChoiceResponse> _selectedChoices;
  String questionText;
  bool isLoading;
  EvidenceRequest evidentRequest;
  int length =0;
  bool isShowFab =false;
  //int selectedPos =0;

  QuestionairePageState(this._appPreference);

  @override
  void initState() {
    answers = new List();
    selectedPoses = new List();
    Utils.showAlert();
    _httpApi = new HTTPApi();

    _loadQuestion([]);

    super.initState();
  }

  void _loadQuestion(List<EvidenceRequest> evidences){
    setState(() => isLoading = true);
    _appPreference.getAge().then((age) {
      _appPreference.getSex().then((sex) {
        this._age = int.parse(age);
        _httpApi
            .submitDiagnosisQuestion(sex, _age, evidences).then((response) {
          setState(() {

            this._diagnosisResponse =
                DiagnosisResponse.fromJson(json.decode(response.body));
            if(_diagnosisResponse ==null){
              _httpApi.submitTriage(sex, _age, _answerJson).then
                (onTriageResponse);
              return;
            }
            this._question = _diagnosisResponse.question;
            this.diagosisItems = _question.diagosisItems;
           // _question.text

            _selectedChoices = List<ChoiceResponse>.generate(_question.diagosisItems
                    .length, (index) =>
            new ChoiceResponse());
            isLoading = false;
          });
          //Clear list once its submitted
          //_answerJson.clear();
        });

      });
    });
  }

  void onTriageResponse(http.Response response){
    final triageResponse = TriageResponse.fromJson(json.decode(response.body));
    Utils.showResultOfInterview(context, triageResponse);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      floatingActionButton: isShowFab ?FloatingActionButton.extended
        (onPressed: (){
          launch("tel://+23480097000010");
      }, label: Text("call"), icon: Icon(Icons.call),): Container(),
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,

        title: Container(
          margin: EdgeInsets.only(top: 50),
          height: 70,
          child: Text(
            "COVID-19 "
            "Diagnostic",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
      body:  isLoading ? Utils.showProgress() :SafeArea(
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
                       // _answerJson.clear();
                        return Card(
                          elevation: 4,
                          child: Wrap(
                            children: <Widget>[
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.all(16),
                                alignment: Alignment.centerLeft,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(flex: 0, child: Text(_question
                                        .diagosisItems[index].name, style: TextStyle( fontSize: 17),)),
                                    Expanded(flex: 0, child: getAnswerTile(index))
                                  ],
                                ),
                              )
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

  Widget getAnswerTile(int pos) {
    final evidentRequest = EvidenceRequest();
    final item = _question.diagosisItems[pos];
    final choices = item.choiceResponses;
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: choices.map((e) {
          return Container(
            padding: EdgeInsets.only(right: 14),
            child: ChoiceChip(
              label: Text(e.getLabel(), style: TextStyle(color:
              _selectedChoices[pos] == e? Colors.white : Colors.black87,
              ),),
              selectedColor: Colors.blueGrey, // The background color for selected chips
              selected: _selectedChoices[pos] == e,
              onSelected: (bool selected) {
                // Is this cip selected?
                if (selected) {
                  length += 1;
                  setState(() {
                    _selectedChoices[pos] = e;
                  });
                  evidentRequest.id = _question.diagosisItems[pos].id;
                  evidentRequest.choiceId =e.id;
                  if(_question.type == 'group_single' || _question.type =='single'){
                    _answerJson.add(evidentRequest);
                    _loadQuestion(_answerJson);
                    length =0;
                  }else{
                    _answerJson.add(evidentRequest);
                    if(length == _selectedChoices.length){
                      _loadQuestion(_answerJson);
                      length =0;
                    }
                  }
                  //print(_selectedChoices[pos].label);
                }
              },
            ),
          );
        }).toList());
  }

}
