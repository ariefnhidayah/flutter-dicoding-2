import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_episode.dart';
import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesDetail useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = new MockTVSeriesRepository();
    useCase = new GetTVSeriesDetail(mockTVSeriesRepository);
  });

  final tvId = 1;
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

  test('should return tv series detail when call the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getDetailTVSeries(tvId)).thenAnswer((_) async => Right(testTVSeriesDetail));
    // act
    final result = await useCase.execute(tvId);
    // assert
    expect(result, Right(testTVSeriesDetail));
  });
}