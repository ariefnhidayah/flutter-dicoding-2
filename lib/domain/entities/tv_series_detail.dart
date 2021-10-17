import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String name;
  final String originalName;
  final String overview;
  final String popularity;
  final String posterPath;
  final List<int> episodeRunTime;
  final String type;
  final String status;
  final String tagline;
  final double voteAverage;
  final int voteCount;
  final List<TVSeriesSeason> seasons;

  TVSeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.episodeRunTime,
    required this.type,
    required this.status,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons
  });
  
  @override
  List<Object?> get props => [
    backdropPath,
    genres,
    id,
    inProduction,
    languages,
    name,
    originalName,
    overview,
    popularity,
    posterPath,
    episodeRunTime,
    type,
    status,
    tagline,
    voteAverage,
    voteCount,
    seasons
  ];

}