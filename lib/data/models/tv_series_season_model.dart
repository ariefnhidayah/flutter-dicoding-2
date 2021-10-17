import 'package:ditonton/data/models/tv_series_episode_model.dart';
import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class TVSeriesSeasonModel extends Equatable {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;
  final int seasonNumber;
  final List<TVSeriesEpisodeModel> episodes;

  TVSeriesSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes
  });

  factory TVSeriesSeasonModel.fromJson(Map<String, dynamic> json) => TVSeriesSeasonModel(
    airDate: json["air_date"],
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    episodes: List<TVSeriesEpisodeModel>.from(json["episodes"].map((x) => TVSeriesEpisodeModel.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
    "episodes": List<dynamic>.from(episodes.map((e) => e.toJson()))
  };

  TVSeriesSeason toEntity() => TVSeriesSeason(
    airDate: airDate,
    episodeCount: episodeCount,
    id: id,
    name: name,
    overview: overview ?? "",
    posterPath: posterPath,
    seasonNumber: seasonNumber,
    episodes: episodes.map((e) => e.toEntity()).toList()
  );
  
  @override
  List<Object?> get props => [];
}