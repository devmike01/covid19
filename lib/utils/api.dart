import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class HTTPApi{

  static const APP_ID ="b49fdb88";
  static const APP_KEY ="eb2e69a769ded6dd72b86cae0cc0f22c";

  Map<String, String> get headers => {
    "Content-Type": "application/json",
    "App-Id": APP_ID,
    "App-Key": APP_KEY
  };

  Future<http.Response> submitDiagnosisQuestion(String sex, int age,
  List<EvidenceRequest> evidences) {
    evidences.forEach((v){
      print("TASSSTK : ${v.id} ${v.choiceId}");
    });

    return http.post(
      EndPoints.COVID_I9_DIAGNOSIS,
      headers: <String, String>{
        'Content-Type': 'application/json',
        "App-Id": APP_ID,
        "App-Key": APP_KEY
      },
      body: jsonEncode(<String, dynamic>{
        'sex': sex.toLowerCase(),
        'age': age,
        'evidence': EvidenceRequest.adapt(evidences)
      }),
    );
  }

  Future<http.Response> submitTriage(String sex, int age,
      List<Map<String, String>> evidences) {
    return http.post(
      EndPoints.COVID_I9_DIAGNOSIS,
      headers: <String, String>{
        'Content-Type': 'application/json',
        "App-Id": APP_ID,
        "App-Key": APP_KEY
      },
      body: jsonEncode(<String, dynamic>{
        'sex': sex,
        'age': age,
        'evidence': evidences
      }),
    );
  }
}

class EndPoints{

  static const BASE_URL ="https://api.infermedica.com";
  static const COVID_I9 ="$BASE_URL/covid19";
  static const COVID_I9_DIAGNOSIS = "$COVID_I9/diagnosis";
  static const COVID_19_TRIAGE ="$COVID_I9/triage";

}
