// cspell:ignore naver, webtoon, toons, titlelist, toon, naver, referer, sprintf

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naver_webtoon/models/webtoon.dart';
import 'package:naver_webtoon/models/webtoon_detail.dart';
import 'package:naver_webtoon/models/webtoon_episode.dart';
import 'package:sprintf/sprintf.dart';

class ApiService {
  static const String referer = 'Referer';
  static const naverWebtoonReferer = 'https://comic.naver.com';

  static const String baseUrl = "https://comic.naver.com";
  static const String dailyToonsList =
      "api/webtoon/titlelist/weekday?order=user";
  static const String webtoonDetail = "api/article/list/info?titleId=%s";
  static const String webtoonEpisodes = "api/article/list?titleId=%s&page=1";
  static const String browseEpisode = "webtoon/detail?titleId=%s&no=%s";

  static const String _titleListMap = 'titleListMap';
  static const String _dayOfWeek = 'dayOfWeek';
  static const String _articleList = 'articleList';

  static Future<List<WebtoonModel>> getDailyToonsList() async {
    List<WebtoonModel> dailyToons = [];
    final url = Uri.parse('$baseUrl/$dailyToonsList');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final toonData = jsonDecode(utf8.decode(res.bodyBytes));
      final todayToons = toonData[_titleListMap][toonData[_dayOfWeek]];

      for (var webtoon in todayToons) {
        dailyToons.add(WebtoonModel.fromJson(webtoon));
      }
      return dailyToons;
    }

    throw Error();
  }

  static Future<WebtoonDetail> getToonById(String id) async {
    final url = Uri.parse(sprintf('$baseUrl/$webtoonDetail', [id]));
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final webtoon = jsonDecode(utf8.decode(res.bodyBytes));

      return WebtoonDetail(webtoon);
    }

    throw Error();
  }

  static Future<List<WebtoonEpisode>> getLatestEpisodesById(String id) async {
    final url = Uri.parse(sprintf('$baseUrl/$webtoonEpisodes', [id]));
    final res = await http.get(url);

    List<WebtoonEpisode> episodeList = [];

    if (res.statusCode == 200) {
      final webtoonEpisodes = jsonDecode(utf8.decode(res.bodyBytes));

      for (var episode in webtoonEpisodes[_articleList]) {
        episodeList.add(WebtoonEpisode.fromJson(episode));
      }

      return episodeList;
    }

    throw Error();
  }
}
