class FirebaseQuestionDetection {
  String q_key;
  String text;
  String? img_key;
  int q_val, level;
  String category;

  List<QuestionOption> optionList;

  FirebaseQuestionDetection({
    required this.text,
    required this.q_key,
    this.img_key,
    required this.q_val,
    required this.level,
    required this.optionList,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      "q_key": q_key,
      "text": text,
      "img_key": img_key,
      "q_val": q_val,
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
      q_key: data['q_key'] ?? '',
      q_val: data['q_val'] ?? 0,
      level: data['level'] ?? 0,
      category: data['category'] ?? '',
      optionList: qol,
    );
  }

  void copyFrom(FirebaseQuestionDetection fd) {
    q_key = fd.q_key;
    text = fd.text;
    img_key = fd.img_key;
    q_val = fd.q_val;
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
