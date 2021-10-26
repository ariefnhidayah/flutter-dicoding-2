import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesRecommendation {
  final TVSeriesRepository repository;

  GetTVSeriesRecommendation(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(int tvId) async {
    return await repository.getRecommendationsTVSeries(tvId);
  }
}