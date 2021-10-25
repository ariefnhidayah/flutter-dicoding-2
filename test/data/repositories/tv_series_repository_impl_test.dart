import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_episode_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_season_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_episode.dart';
import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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

  group('Now Playing TV Series', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getNowPlayingTVSeries()).thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getNowPlayingTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getNowPlayingTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async{
      // arrange
      when(mockTVSeriesRemoteDataSource.getNowPlayingTVSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getNowPlayingTVSeries());
      expect(result, equals(Left(ServerFailure('Something went wrong'))));
    });

    test('should return connection failure when device is not internet connection', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getNowPlayingTVSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getNowPlayingTVSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    
    test('should return remote data when call remote data source is successfull', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getPopularTVSeries()).thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getPopularTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test('should return server failure when call remote data source is unsuccessfull', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getPopularTVSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getPopularTVSeries());
      expect(result, equals(Left(ServerFailure('Something went wrong'))));
    });

    test('should return connection failure when device is not have internet connection', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getPopularTVSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getPopularTVSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

  });

  group('Top Rated TV Series', () {
    
    test('should return remote data when call remote data source is successful', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTopRatedTVSeries()).thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getTopRatedTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test('should return server failure when call remote data is unsuccessful', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTopRatedTVSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getTopRatedTVSeries());
      expect(result, equals(Left(ServerFailure('Something went wrong'))));
    });

    test('should return connection failure when device is not have internet connection', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTopRatedTVSeries()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getTopRatedTVSeries());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

  });

  group('Get TV Series Detail', () {
    int tvId = 1;
    TVSeriesDetail testTVSeriesDetail = new TVSeriesDetail(
      backdropPath: '/path.jpg',
      episodeRunTime: [],
      overview: 'Overview',
      originalName: 'Squid Game',
      popularity: 7231.019,
      posterPath: '/path.jpg',
      voteAverage: 9,
      voteCount: 7632,
      genres: [Genre(id: 1, name: 'Action')],
      id: tvId,
      inProduction: false,
      languages: ['en'],
      name: 'Squid Game',
      status: 'End',
      tagline: 'tagline',
      type: 'type',
      seasons: [
        TVSeriesSeason(
          airDate: '2021-10-10',
          episodeCount: 1,
          id: 1,
          name: 'Squid Game S1',
          overview: 'Overview',
          posterPath: '/path.jpg',
          seasonNumber: 1,
          episodes: [
            TVSeriesEpisode(
              airDate: '2021-10-01',
              episodeNumber: 1,
              id: 1,
              name: 'Episode 1',
              overview: 'Overview',
              stillPath: '/path.jpg',
              voteAverage: 1,
              voteCount: 1
            )
          ]
        )
      ],
    );

    TVSeriesDetailModel tvSeriesDetailModel = new TVSeriesDetailModel(
      backdropPath: '/path.jpg',
      episodeRunTime: [],
      overview: 'Overview',
      originalName: 'Squid Game',
      popularity: 7231.019,
      posterPath: '/path.jpg',
      voteAverage: 9,
      voteCount: 7632,
      genres: [GenreModel(id: 1, name: 'Action')],
      id: tvId,
      inProduction: false,
      languages: ['en'],
      name: 'Squid Game',
      status: 'End',
      tagline: 'tagline',
      type: 'type',
      seasons: [
        TVSeriesSeasonModel(
          airDate: '2021-10-10',
          episodeCount: 1,
          id: 1,
          name: 'Squid Game S1',
          overview: 'Overview',
          posterPath: '/path.jpg',
          seasonNumber: 1,
          episodes: [
            TVSeriesEpisodeModel(
              airDate: '2021-10-01',
              episodeNumber: 1,
              id: 1,
              name: 'Episode 1',
              overview: 'Overview',
              stillPath: '/path.jpg',
              voteAverage: 1,
              voteCount: 1
            )
          ]
        )
      ],
    );

    test('should return remote data when call remote data source is successful', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getDetailTVSeries(tvId)).thenAnswer((_) async => tvSeriesDetailModel);
      // act
      final result = await repository.getDetailTVSeries(tvId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getDetailTVSeries(tvId));
      expect(result, equals(Right(testTVSeriesDetail)));
    });

    test('should return server failure when call remote data source is unsuccessful', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getDetailTVSeries(tvId)).thenThrow(ServerException());
      // act
      final result = await repository.getDetailTVSeries(tvId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getDetailTVSeries(tvId));
      expect(result, equals(Left(ServerFailure('Something went wrong'))));
    });

    test('should return connection failure when device is not have internet connection', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getDetailTVSeries(tvId)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetailTVSeries(tvId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getDetailTVSeries(tvId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

  });

  group('Get Recommendations', () {
    int tvId = 1;
    test('should return remote data when call the remote data source is successfull', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getRecommendationsTVSeries(tvId)).thenAnswer((_) async => tvSeriesModelList);
      // act
      final result = await repository.getRecommendationsTVSeries(tvId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getRecommendationsTVSeries(tvId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvSeriesList);
    });

    test('should return server failure when call remote data source is unsuccessful', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getRecommendationsTVSeries(tvId)).thenThrow(ServerException());
      // act
      final result = await repository.getRecommendationsTVSeries(tvId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getRecommendationsTVSeries(tvId));
      expect(result, equals(Left(ServerFailure('Something went wrong'))));
    });

    test('should return connection failure when device is not internet connection', () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getRecommendationsTVSeries(tvId)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendationsTVSeries(tvId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getRecommendationsTVSeries(tvId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

  });
}