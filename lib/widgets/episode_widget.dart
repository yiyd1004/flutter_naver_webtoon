// cspell:ignore webtoon, naver, sprintf

import 'package:flutter/material.dart';
import 'package:naver_webtoon/models/webtoon_episode.dart';
import 'package:naver_webtoon/services/api_service.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final WebtoonEpisode episode;
  final String webtoonId;

  onButtonTap() async {
    print(sprintf('${ApiService.baseUrl}/${ApiService.browseEpisode}',
        [webtoonId, episode.id]));
    await launchUrlString(sprintf(
        '${ApiService.baseUrl}/${ApiService.browseEpisode}',
        [webtoonId, episode.id]));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
