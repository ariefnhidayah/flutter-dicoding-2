import 'package:equatable/equatable.dart';

class TVSeriesEpisode extends Equatable {
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  TVSeriesEpisode({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount
  });

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