import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tvSeriesModel = TVSeriesModel(
    backdropPath: "/path.jpg",
    originalName: "Squid Game",
    name: "Squid Game",
    genreIds: [
      10759,
      9648,
      18
    ],
    popularity: 7231.019,
    id: 93405,
    overview: "overview",
    posterPath: "/path.jpg",
    voteAverage: 7.9,
    voteCount: 7623
  );

  final tvSeriesResponseModel = TVSeriesResponse(tvSeries: <TVSeriesModel> [tvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/popular_tv_series.json'));
      // act
      final results = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(results, tvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a valid model to JSON', () async {
      // arrange

      // act
      final results = tvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [{
            "backdrop_path": "/n00M5kO1C9xBkusfe56Zvrihw6c.jpg",
            "genre_ids": [
                10759,
                9648,
                18
            ],
            "id": 93405,
            "name": "Squid Game",
            "original_name": "오징어 게임",
            "overview": "Hundreds of cash-strapped players accept a strange invitation to compete in children's games—with high stakes. But, a tempting prize awaits the victor.",
            "popularity": 7231.019,
            "poster_path": "/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg",
            "vote_average": 7.9,
            "vote_count": 7623
        }]
      };
      expect(results, expectedJsonMap);
    });
  });
}