import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvSeriesModel = TVSeriesModel(
    backdropPath: "/path.jpg",
    originalName: "Squid Game",
    name: "Squid Game",
    genreIds: [
      10759,
      9648,
      18
    ],
    popularity: 7231.019,
    id: 93405,
    overview: "overview",
    posterPath: "/path.jpg",
    voteAverage: 7.9,
    voteCount: 7623
  );

  final tvSeries = TVSeries(
    backdropPath: "/path.jpg",
    originalName: "Squid Game",
    name: "Squid Game",
    genreIds: [
      10759,
      9648,
      18
    ],
    popularity: 7231.019,
    id: 93405,
    overview: "overview",
    posterPath: "/path.jpg",
    voteAverage: 7.9,
    voteCount: 7623
  );

  test('should be a subclass of Movie entity', () async {
    final result = tvSeriesModel.toEntity();
    expect(result, tvSeries);
  });
}