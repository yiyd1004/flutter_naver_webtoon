// cspell:ignore webtoon

class WebtoonEpisode {
  final String id, title, rating, date, thumb;

  WebtoonEpisode.fromJson(Map<String, dynamic> json)
      : id = json['no'].toString(),
        title = json['subtitle'],
        rating = json['starScore'].toString(),
        date = json['serviceDateDescription'],
        thumb = json['thumbnailUrl'];
}
