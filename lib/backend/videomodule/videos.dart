class Videos {
  String caption;
  String url;
  String description;
  String category;
  String? key;

  Videos(
      {required this.caption,
      required this.url,
      required this.description,
      required this.category,
      this.key});

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'url': url,
      'description': description,
      'category': category,
    };
  }

  static Videos fromMap(Map<String, dynamic> data) {
    return Videos(
        caption: data['caption'] ?? '',
        url: data['url'] ?? '',
        description: data['description'] ?? '',
        category: data['category'] ?? '');
  }

  void copyFrom(Videos other){
    category = other.category;
    caption=other.caption;
    description=other.description;
    url=other.url;
    key=other.key;
  }
}
