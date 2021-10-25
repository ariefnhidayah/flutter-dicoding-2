import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
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
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Something went wrong'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Something went wrong'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries() async {
    try {
      final result = await tvSeriesRemoteDataSource.getTopRatedTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Something went wrong'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TVSeriesDetail>> getDetailTVSeries(int tvId) async {
    try {
      final result = await tvSeriesRemoteDataSource.getDetailTVSeries(tvId);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure('Something went wrong'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getRecommendationsTVSeries(int tvId) async {
    try {
      final result = await tvSeriesRemoteDataSource.getRecommendationsTVSeries(tvId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Something went wrong'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
}