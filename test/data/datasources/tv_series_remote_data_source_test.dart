import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('Popular TV Series', () {
    final tvSeriesList = TVSeriesResponse.fromJson(json.decode(readJson('dummy_data/tv_series_popular.json'))).tvSeries;

    test('should be return list tv series when status code 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTVSeries();
      // asserts
      expect(result, tvSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTVSeries();
      // asserts
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Top Rated TV Series', () {
    final tvSeriesList = TVSeriesResponse.fromJson(json.decode(readJson('dummy_data/tv_series_top_rated.json'))).tvSeries;

    test('should be return list tv series when status code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVSeries();
      // asserts
      expect(result, tvSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVSeries();
      // asserts
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Now Playing TV Series', () {
    final tvSeriesList = TVSeriesResponse.fromJson(json.decode(readJson('dummy_data/tv_series_now_playing.json'))).tvSeries;

    test('should be return list tv series when status code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTVSeries();
      // asserts
      expect(result, tvSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTVSeries();
      // asserts
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('TV Series Detail', () {
    final tvId = 93405;

    Map<String, dynamic> tvDetailJson = json.decode(readJson('dummy_data/tv_series_detail.json'));
    tvDetailJson["seasons"].map((x) {
      x["episodes"] = json.decode(readJson("dummy_data/tv_series_detail_season.json"))['episodes'];
    }).toList();

    final season = 1;

    final tvDetail = TVSeriesDetailModel.fromJson(tvDetailJson);

    test('should be return detail tv series when status code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_detail.json'), 200));
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId/season/$season?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_detail_season.json'), 200));
      // act
      final result = await dataSource.getDetailTVSeries(tvId);
      // asserts
      expect(result, equals(tvDetail));
    });

    test('should be throw a ServerException when the response api season detail is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_detail.json'), 200));
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId/season/$season?$API_KEY'))).thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getDetailTVSeries(tvId);
      // asserts
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('should be throw a ServerException when the response api tv series detail is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY'))).thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getDetailTVSeries(tvId);
      // asserts
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('TV Recommendations', () {
    final tvId = 93405;
    final tvSeriesList = TVSeriesResponse.fromJson(json.decode(readJson('dummy_data/tv_series_recommendations.json'))).tvSeries;

    test('should be return list tv series when status is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_series_recommendations.json'), 200));
      // act
      final result = await dataSource.getRecommendationsTVSeries(tvId);
      // asserts
      expect(result, tvSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY'))).thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getRecommendationsTVSeries(tvId);
      // asserts
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
