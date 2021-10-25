import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockTVSeriesRemoteDataSource;

  setUp((){
    mockTVSeriesRemoteDataSource = new MockTVSeriesRemoteDataSource();
    repository = new TVSeriesRepositoryImpl(tvSeriesRemoteDataSource: mockTVSeriesRemoteDataSource);
  });

  TVSeriesModel tvSeriesModel = TVSeriesModel(
    backdropPath: '/path.jpg',
    genreIds: [10759,9648, 18],
    id: 93405,
    name: "Squid Game",
    originalName: "Squid Game",
    overview: "Overview",
    popularity: 7231.019,
    posterPath: "/path.jpg",
    voteAverage: 9,
    voteCount: 7623
  );

  TVSeries tvSeries = new TVSeries(
    backdropPath: '/path.jpg',
    genreIds: [10759,9648, 18],
    id: 93405,
    name: "Squid Game",
    originalName: "Squid Game",
    overview: "Overview",
    popularity: 7231.019,
    posterPath: "/path.jpg",
    voteAverage: 9,
    voteCount: 7623
  );

  final tvSeriesModelList = <TVSeriesModel>[tvSeriesModel];
  final tvSeriesList = <TVSeries>[tvSeries];

  
}