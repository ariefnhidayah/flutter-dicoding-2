import 'package:ditonton/domain/entities/tv_series_episode.dart';
import 'package:equatable/equatable.dart';

class TVSeriesEpisodeModel extends Equatable {
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  TVSeriesEpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount
  });

  factory TVSeriesEpisodeModel.fromJson(Map<String, dynamic> json) => TVSeriesEpisodeModel(
    airDate: json["air_date"],
    episodeNumber: json["episode_number"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    stillPath: json["still_path"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"]
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "episode_number": episodeNumber,
    "id": id,
    "name": name,
    "overview": overview,
    "still_path": stillPath,
    "vote_average": voteAverage,
    "vote_count": voteCount
  };

  TVSeriesEpisode toEntity() => TVSeriesEpisode(
    airDate: airDate,
    episodeNumber: episodeNumber,
    id: id,
    name: name,
    overview: overview,
    stillPath: stillPath,
    voteAverage: voteAverage,
    voteCount: voteCount
  );
  
  @override
  List<Object?> get props => [
    airDate,
    episodeNumber,
    id,
    name,
    overview,
    stillPath,
    voteAverage,
    voteCount
  ];
}