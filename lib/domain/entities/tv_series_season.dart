import 'package:ditonton/domain/entities/tv_series_episode.dart';
import 'package:equatable/equatable.dart';

class TVSeriesSeason extends Equatable {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final List<TVSeriesEpisode> episodes;

  TVSeriesSeason({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes
  });
  
  @override
  List<Object?> get props => [
    airDate,
    episodeCount,
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
    episodes
  ];
}