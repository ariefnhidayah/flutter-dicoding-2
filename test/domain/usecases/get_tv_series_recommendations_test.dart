import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesRecommendation useCase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = new MockTVSeriesRepository();
    useCase = GetTVSeriesRecommendation(mockTVSeriesRepository);
  });

  final tvId = 1;
  final tvSeriesList = <TVSeries>[];

  test('should return list recommendations when call the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getRecommendationsTVSeries(tvId)).thenAnswer((_) async => Right(tvSeriesList));
    // act
    final result = await useCase.execute(tvId);
    // assert
    expect(result, Right(tvSeriesList));
  });
}