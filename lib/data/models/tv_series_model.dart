import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  String name;
  double voteAverage;
  int voteCount;

  TVSeriesModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount
  });

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"],
    posterPath: json["poster_path"],
    name: json["name"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"]
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount
  };

  TVSeries toEntity() => TVSeries(
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    originalName: originalName,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    name: name,
    voteAverage: voteAverage,
    voteCount: voteCount
  );
  
  @override
  List<Object?> get props => [
    backdropPath,
    genreIds,
    id,
    originalName,
    overview,
    popularity,
    posterPath,
    name,
    voteAverage,
    voteCount
  ];
}