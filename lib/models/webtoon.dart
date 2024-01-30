class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['titleName'],
        thumb = json['thumbnailUrl'],
        id = json['titleId'].toString();
}
