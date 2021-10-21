import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TVSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview
  });

  factory TVSeriesTable.fromEntity(TVSeriesDetail tvSeries) => TVSeriesTable(
    id: tvSeries.id,
    name: tvSeries.name,
    posterPath: tvSeries.posterPath,
    overview: tvSeries.overview
  );

  factory TVSeriesTable.fromMap(Map<String, dynamic> json) => TVSeriesTable(
    id: json["id"],
    name: json["name"],
    posterPath: json["poster_path"],
    overview: json["overview"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "poster_path": posterPath,
    "overview": overview
  };

  TVSeries toEntity() => TVSeries.watchlist(
    id: id,
    name: name,
    posterPath: posterPath,
    overview: overview
  );

  @override
  List<Object?> get props => [
    id,
    name,
    posterPath,
    overview
  ];
}