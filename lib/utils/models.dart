import 'dart:html';

class DiagnosisResponse{

  QuestionResponse question;

  bool shouldStop;

  DiagnosisResponse({this.question, this.shouldStop});

  bool isShouldStop() => shouldStop;

  void setShouldStop(bool shouldStop){
    this.shouldStop = shouldStop;
  }

  QuestionResponse getQuestionResponse() => question;

  void setQuestionResponse(QuestionResponse question){
    this.question = question;
  }

  factory DiagnosisResponse.fromJson(Map<String, dynamic> json) {
    return DiagnosisResponse(
      question: json['question'],
      shouldStop: json['should_stop'],
    );
  }
}

class ChoiceResponse{
  String id;
  String label;

  String getId() => id;

  String getLabel() => label;

  void setLabel(String label){
    this.label = label;
  }

  void setId(String id){
    this.id = id;
  }
}

class DiagnosisItem{

  List<ChoiceResponse> choiceResponses;

  String explanation;

  String id;

  String name;

  void setExplanation(String explanation){
    this.explanation = explanation;
  }

  String getExplanation() => explanation;

  String getId() => id;

  void setId(String id){
    this.id = id;
  }

  void setName(String name){
    this.name = name;
  }

  String getName() => name;

}

class QuestionResponse{

  String text;

  String type;

  List<DiagnosisItem> diagosisItems;


  List<DiagnosisItem> getDiagnosis() => diagosisItems;

  void setDiagosisItems(List<DiagnosisItem> diagosisItems){
    this.diagosisItems = diagosisItems;
  }

  String getText() => text;

  String getType() => type;

  void setText(String text){
    this.text = text;
  }

  void setType(String type){
    this.type = type;
  }
}