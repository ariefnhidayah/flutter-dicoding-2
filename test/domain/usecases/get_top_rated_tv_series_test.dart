import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVSeries useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    useCase = GetTopRatedTVSeries(mockTVSeriesRepository);
  });

  final tvSeriesList = <TVSeries>[];

  test('should get list from repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTopRatedTVSeries()).thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tvSeriesList));
  });
}