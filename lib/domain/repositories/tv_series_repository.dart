import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getNowPlayingTVSeries();
}