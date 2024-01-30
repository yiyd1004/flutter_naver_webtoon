// cspell:ignore naver, webtoon, toons, titlelist, toon

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naver_webtoon/models/webtoon.dart';

class ApiService {
  final String baseUrl = "https://comic.naver.com/api";
  final String dailyToonsList = "webtoon/titlelist/weekday?order=user";
  final String webtoon = "article/list?titleId=819217&page=1";

  Future<List<WebtoonModel>> getDailyToonsList() async {
    List<WebtoonModel> dailyToons = [];
    final url = Uri.parse('$baseUrl/$dailyToonsList');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final toonData = jsonDecode(utf8.decode(res.bodyBytes));
      final todayToons = toonData['titleListMap'][toonData['dayOfWeek']];

      for (var webtoon in todayToons) {
        dailyToons.add(WebtoonModel.fromJson(webtoon));
      }
      return dailyToons;
    }

    throw Error();
  }
}
