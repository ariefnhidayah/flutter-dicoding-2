import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_season_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailModel extends Equatable {
  final String? backdropPath;
  final List<GenreModel> genres;
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
  final List<TVSeriesSeasonModel> seasons;

  TVSeriesDetailModel({
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

  factory TVSeriesDetailModel.fromJson(Map<String, dynamic> json) => TVSeriesDetailModel(
    backdropPath: json["backdrop_path"],
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    id: json["id"],
    inProduction: json["in_production"],
    languages: json["languages"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"],
    posterPath: json["poster_path"],
    episodeRunTime: json["episode_run_time"],
    type: json["type"],
    status: json["status"],
    tagline: json["tagline"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
    seasons: List<TVSeriesSeasonModel>.from(json["seasons"].map((x) => TVSeriesSeasonModel.fromJson(x))),
    overview: json["overview"]
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genres": List<dynamic>.from(genres.map((e) => e.toJson())),
    "id": id,
    "in_production": inProduction,
    "languages": languages,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "poster_path": posterPath,
    "episode_run_time": episodeRunTime,
    "type": type,
    "status": status,
    "tagline": tagline,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "overview": overview,
    "seasons": List<dynamic>.from(seasons.map((e) => e.toJson()))
  };

  TVSeriesDetail toEntity() => TVSeriesDetail(
    backdropPath: backdropPath,
    genres: genres.map((e) => e.toEntity()).toList(),
    id: id,
    inProduction: inProduction,
    languages: languages,
    name: name,
    originalName: originalName,
    popularity: popularity,
    posterPath: posterPath,
    episodeRunTime: episodeRunTime,
    type: type,
    status: status,
    tagline: tagline,
    voteAverage: voteAverage,
    voteCount: voteCount,
    overview: overview,
    seasons: seasons.map((e) => e.toEntity()).toList()
  );
  
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