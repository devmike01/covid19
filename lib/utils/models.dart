
class DiagnosisResponse{

  QuestionResponse question;

  bool shouldStop;

  List<dynamic> conditions;

  DiagnosisResponse({this.question, this.shouldStop, this.conditions});

  bool isShouldStop() => shouldStop;

  QuestionResponse getQuestionResponse() => question;

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return DiagnosisResponse(
      question: QuestionResponse.fromJson(json['question']),
      shouldStop: json['should_stop'],
        conditions: json['conditions']
    );
  }


}

class ChoiceResponse{
  String id;
  String label;

  String getId() => id;

  String getLabel() => label;

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

  String text;

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
        type: json['type']

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


}