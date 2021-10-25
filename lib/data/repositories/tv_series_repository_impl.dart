import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource tvSeriesRemoteDataSource;

  TVSeriesRepositoryImpl({
    required this.tvSeriesRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<TVSeries>>> getNowPlayingTVSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getNowPlayingTVSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Something went wrong!'));
    } on SocketException {
      return Left(ConnectionFailure('Something went wrong!'));
    }
  }
  
}