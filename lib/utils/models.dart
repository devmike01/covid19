
//import 'package:floor_generator/value_object/primary_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:floor/floor.dart';

@entity
class DiagnosisResponse{

  @PrimaryKey(autoGenerate: true)
  final int id =0;

  QuestionResponse question;

  bool shouldStop;

  List<dynamic> conditions;

  DiagnosisResponse({this.question, this.shouldStop, this
      .conditions});

  bool isShouldStop() => shouldStop;

  QuestionResponse getQuestionResponse() => question;

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return json['question'] == null? null:  DiagnosisResponse(
      question: QuestionResponse
            .fromJson
        (json['question']),
      shouldStop: json['should_stop'],
        conditions: json['conditions']
    );
  }


}

class ChoiceResponse{
  String id;
  String label;

  bool isChecked = false;
  int selectedItem =1;

  String getId() => id;

  String getLabel() => label;

  bool hasChecked() => isChecked;

  ChoiceResponse({this.id, this.label});

  factory ChoiceResponse.fromJson(Map<String, dynamic> json) {
    return ChoiceResponse(
      id: json['id'],
      label: json['label'],
    );
  }
}

class DiagnosisItem{

  List<ChoiceResponse> choiceResponses;

  String explanation;

  String id;

  String name;

  bool isSelected =false;


  String getExplanation() => explanation;

  String getId() => id;
  String getName() => name;

  DiagnosisItem({this.id, this.name, this.explanation, this.choiceResponses});

  factory DiagnosisItem.fromJson(Map<String, dynamic> json) {
    return DiagnosisItem(
      id: json['id'],
      name: json['name'],
      explanation: json['explanation'],
      choiceResponses:List.from( json['choices'].map((choices) => ChoiceResponse.fromJson(choices)))
    );
  }

}

class QuestionResponse{

  String text ='';

  String type;

  List<DiagnosisItem> diagosisItems;

  bool isSelected = false;

  List<DiagnosisItem> getDiagnosis() => diagosisItems;

  String getText() => text;

  String getType() => type;

  QuestionResponse({this.text, this.diagosisItems, this.type});

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
        text: json['text'],
        diagosisItems: new List.from(json['items'].map((items) => DiagnosisItem
            .fromJson(items))),
        type: json["type"]

    );
  }



}


class EvidenceRequest{
  String choiceId;
  String id;

  EvidenceRequest({this.id, this.choiceId});

  String getId() => id;

  String getChoiceId() => choiceId;

  static Map<String, dynamic> toMap(String id, String choiceId){
    return {
      'id': id,
      'choice_id' :choiceId,
    };
  }

  static List<Map<String, dynamic>> adapt(List<EvidenceRequest> jsons){
    final request = List<Map<String, dynamic>>();
    jsons.forEach((json){
      final map = {
        'id': json.id,
        'choice_id': json.choiceId
      };
      request.add(map);
    });
    return request;
  }

  factory EvidenceRequest.fromJson(Map<String, dynamic> json){
    return EvidenceRequest(
      id: json['id'],
      choiceId: json['choice_id']
    );
  }
}

class TriageResponse{

  String description;

  String label;

  String triageLevel;

  List<SeriousResponse> seriousResponses;

  TriageResponse({this.label, this.description, this.triageLevel, this
      .seriousResponses});


  factory TriageResponse.fromJson(Map<String, dynamic> json){

    return TriageResponse(
      label: json['label'],
      description: json['description'],
      triageLevel: json['triage_level'],
      seriousResponses: List.from(json['serious'].map((items) =>
        SeriousResponse.fromJson(items)))
    );
  }

}

class SeriousResponse{
  String commonName;
  String id;
  bool isEmergency;
  String name;

  SeriousResponse({this.id, this.name, this.commonName, this.isEmergency});

  factory SeriousResponse.fromJson(Map<String, dynamic> json){
    return SeriousResponse(
    id: json['id'],
      isEmergency: json['is_emergency'],
      commonName: json['common_name'],
      name: json['name']
    );
  }
}