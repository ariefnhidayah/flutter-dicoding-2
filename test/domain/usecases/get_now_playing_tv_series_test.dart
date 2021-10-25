import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTVSeries useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    useCase = GetNowPlayingTVSeries(mockTVSeriesRepository);
  });

  final tvSeriesList = <TVSeries>[];

  test('should get list tv series from repository', () async {
    // arrange
    when(mockTVSeriesRepository.getNowPlayingTVSeries()).thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await useCase.execute();
    // asert
    expect(result, Right(tvSeriesList));
  });
}