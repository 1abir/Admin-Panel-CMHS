class FirebaseQuestionDetection {
  String qKey;
  String text;
  String? imgKey;
  int qVal, level;
  String category;

  List<QuestionOption> optionList;

  FirebaseQuestionDetection({
    required this.text,
    required this.qKey,
    this.imgKey,
    required this.qVal,
    required this.level,
    required this.optionList,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      "q_key": qKey,
      "text": text,
      "img_key": imgKey,
      "q_val": qVal,
      "level": level,
      "category": category,
      "optionList": [...optionList.map((element) => element.toMap())]
    };
  }

  static FirebaseQuestionDetection fromMap(Map<String, dynamic> data) {
    List<QuestionOption> qol = [];
    if (data.containsKey('optionList')) {
      final dl = [...data['optionList']];
      dl.forEach((e) {
        Map<String, dynamic> v = (e as Map<String, dynamic>);
        QuestionOption qo = QuestionOption.fromMap(v);
        qol.add(qo);
      });
    }

    return FirebaseQuestionDetection(
      text: data['text'] ?? '',
      qKey: data['q_key'] ?? '',
      qVal: data['q_val'] ?? 0,
      level: data['level'] ?? 0,
      category: data['category'] ?? '',
      optionList: qol,
    );
  }

  void copyFrom(FirebaseQuestionDetection fd) {
    qKey = fd.qKey;
    text = fd.text;
    imgKey = fd.imgKey;
    qVal = fd.qVal;
    level = fd.level;
    optionList = fd.optionList;
    category = fd.category;
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
