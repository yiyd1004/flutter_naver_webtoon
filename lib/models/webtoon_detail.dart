//cspell:ignore webtoon, naver

class WebtoonDetail {
  late String title, about, thumb, genre, age;

  WebtoonDetail(Map<String, dynamic> json) {
    title = json['titleName'];
    about = json['synopsis'];
    genre = _getGenre(json['curationTagList']);
    age = json['age']['description'];
    thumb = json['sharedThumbnailUrl'];
  }

  String _getGenre(List json) {
    if (json.isEmpty) {
      return genre;
    }

    return json.map((item) => item['tagName']).join(', ');
  }
}
