class Article {
  String head;
  String category;
  String type;
  String url;
  String bodyHtml;
  late String? key;

  Article(
      {required this.head,
      required this.category,
      required this.type,
      required this.url,
      required this.bodyHtml,
      this.key
      });

  Map<String, dynamic> toMap() {
    return {
      'head': head,
      'category': category,
      'type': type,
      'url': url,
      'bodyHtml': bodyHtml
    };
  }

  static Article fromMap(Map<String, dynamic> data) {
    return Article(
        head: data['head'] ?? '',
        category: data['category'] ?? '',
        type: data['type'] ?? '',
        url: data['url'] ?? '',
        bodyHtml: data['bodyHtml'] ?? '',
        key: data['key']);
  }

  void copyFrom(Article another){
    head = another.head;
    category = another.category;
    type=another.type;
    url=another.url;
    bodyHtml=another.bodyHtml;
    key = another.key;
  }
}
