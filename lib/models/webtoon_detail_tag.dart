// cspell:ignore webtoon

class WebtoonDetailTag {
  final String id, tagName;

  WebtoonDetailTag.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        tagName = json['tagName'];
}
