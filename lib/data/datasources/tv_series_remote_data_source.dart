import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_episode_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<List<TVSeriesModel>> getNowPlayingTVSeries();
  Future<TVSeriesDetailModel> getDetailTVSeries(int tvId);
  Future<List<TVSeriesEpisodeModel>> getDetailSeasonEpisodes(int tvId, int season);
  Future<List<TVSeriesModel>> getRecommendationsTVSeries(int tvId);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVSeriesRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getNowPlayingTVSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailModel> getDetailTVSeries(int tvId) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY'));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      for(int i = 0; i < (result['seasons'] as List).length; i++) {
        List<TVSeriesEpisodeModel> tvEpisodes = await getDetailSeasonEpisodes(tvId, result['seasons'][i]['season_number']);
        List<Map<String, dynamic>> episodes = [];
        for(int j = 0; j < tvEpisodes.length; j++) {
          episodes.add(tvEpisodes[j].toJson());
        }
        result['seasons'][i]['episodes'] = episodes;
      }
      
      return TVSeriesDetailModel.fromJson(result);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesEpisodeModel>> getDetailSeasonEpisodes(int tvId, int season) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$tvId/season/$season?$API_KEY'));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<TVSeriesEpisodeModel> data = [];
      
      for(int i = 0; i < (result['episodes'] as List).length; i++) {
        data.add(TVSeriesEpisodeModel.fromJson(result['episodes'][i]));
      }
      
      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getRecommendationsTVSeries(int tvId) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }
}