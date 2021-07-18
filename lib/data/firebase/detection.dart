import 'dart:convert';

class FirebaseQuestionDetection {
  String q_key;
  String text;
  String? img_key;

  int q_val, level;

  List<QuestionOption> optionList;

  FirebaseQuestionDetection(
      {required this.text,
      required this.q_key,
      this.img_key,
      required this.q_val,
      required this.level,
      required this.optionList});

  Map<String, dynamic> toMap() {
    return {
      "q_key": q_key,
      "text": text,
      "img_key": img_key,
      "q_val": q_val,
      "level": level,
      "optionList": [...optionList.map((element) => element.toMap())]
    };
  }

  static FirebaseQuestionDetection fromMap(Map<String, dynamic> data) {
    List<QuestionOption> qol = [];
    if (data.containsKey('optionList')) {
      // (data['optionList'] as List).map((e) {
      //   print("Inside ");
      //   print(e.toString());
      //   QuestionOption qo = QuestionOption.fromMap(e);
      //   print(qo.toMap().toString());
      //   qol.add(qo);
      //   return e;
      // });
      // print("inside");
      // final jd = jsonDecode(data['optionList']);
      // print("JSon Decode " + jd.toString());
      final dl = [...data['optionList']];
      // print(dl.runtimeType.toString());
      // print("length: " + dl.length.toString());
      // if (dl.length == 0) {
      //   print(data['text']);
      //   print(data['q_key']);
      //   print(data['level']);
      //   print("Option List" + data['optionList'].toString());
      // } else {
      //   print("else: " + data['text']);
      // }
      // print
      dl.forEach((e) {
        // print("Inside map");
        // print(e.toString());
        Map<String, dynamic> v = (e as Map<String, dynamic>);
        // print(v.runtimeType.toString());
        // print(v.toString());
        QuestionOption qo = QuestionOption.fromMap(v);
        // print("output map: " + qo.toMap().toString());
        qol.add(qo);
      });
      // print("finalqol:" + qol.toString());
    }

    return FirebaseQuestionDetection(
        text: data['text'] ?? '',
        q_key: data['q_key'] ?? '',
        q_val: data['q_val'] ?? 0,
        level: data['level'] ?? 0,
        optionList: qol);
  }
}

class QuestionOption {
  String text;
  int value;

  QuestionOption({required this.text, required this.value});

  Map<String, dynamic> toMap() {
    return {"text": text, "value": value};
  }

  static QuestionOption fromMap(Map<String, dynamic> data) {
    return QuestionOption(text: data['text'] ?? '', value: data['value'] ?? 0);
  }
}
