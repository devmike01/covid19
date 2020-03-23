import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPApi{

  Map<String, String> get headers => {
    "Content-Type": "application/json",
    "App-Id": "b49fdb88",
    "App-Key": "eb2e69a769ded6dd72b86cae0cc0f22c"
  };

  Future<http.Response> submitDiagnosisQuestion(String title, String age,
  List<EvidenceRequest> evidences) {
    return http.post(
      EndPoints.COVID_I9_DIAGNOSIS,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sex': title,
        'age': age,
        'evidence': evidences
      }),
    );
  }

  Future<http.Response> submitTriage(String title, String age,
      List<EvidenceRequest> evidences) {
    return http.post(
      EndPoints.COVID_I9_DIAGNOSIS,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sex': title,
        'age': age,
        'evidence': evidences
      }),
    );
  }
}

class EndPoints{

  static const BASE_URL ="api.infermedica.com";
  static const COVID_I9 ="$BASE_URL/covid19";
  static const COVID_I9_DIAGNOSIS = "$COVID_I9/diagnosis";
  static const COVID_19_TRIAGE ="$COVID_I9/triage";

}

class EvidenceRequest{
  String choiceId;
  String id;

  String getId() => id;

  String getChoiceId() => choiceId;

  void setId(String id){
    this.id = id;
  }

  void setChoiceId(String choiceId){
    this.choiceId = choiceId;
  }
}

class DiagnosisResponse{

  Map<String, dynamic> get(){
    return {
      "conditions": [],
      "extras": {},
      "question": {
        "explanation": null,
        "extras": {},
        "items": [
          {
            "choices": [
              {
                "id": "present",
                "label": "Yes"
              },
              {
                "id": "absent",
                "label": "No"
              }
            ],
            "explanation": null,
            "id": "s_0",
            "name": "Fever"
          },
          {
            "choices": [
              {
                "id": "present",
                "label": "Yes"
              },
              {
                "id": "absent",
                "label": "No"
              }
            ],
            "explanation": null,
            "id": "s_1",
            "name": "Cough"
          },
          {
            "choices": [
              {
                "id": "present",
                "label": "Yes"
              },
              {
                "id": "absent",
                "label": "No"
              }
            ],
            "explanation": "Shortness of breath: When you have trouble breathing and you cannot get enough air into your lungs. Often accompanied by chest tightness, breathlessness or a feeling of suffocation.",
            "id": "s_2",
            "name": "Shortness of breath"
          }
        ],
        "text": "Do you have any of the following symptoms? Please only select new symptoms and symptoms that are not related to any chronic disease you may be subject to.",
        "type": "group_multiple"
      },
      "should_stop": false
    };
  }
}