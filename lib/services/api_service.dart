// cspell:ignore naver, webtoon, toons, titlelist, toon, naver, referer

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naver_webtoon/models/webtoon.dart';

class ApiService {
  static const referer = 'Referer';
  static const naverWebtoonReferer = 'https://comic.naver.com';

  static const String baseUrl = "https://comic.naver.com/api";
  static const String dailyToonsList = "webtoon/titlelist/weekday?order=user";
  static const String webtoon = "article/list?titleId=819217&page=1";

  static Future<List<WebtoonModel>> getDailyToonsList() async {
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
