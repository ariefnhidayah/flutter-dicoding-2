import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> tvSeries;

  TVSeriesResponse({
    required this.tvSeries
  });

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) => TVSeriesResponse(
    tvSeries: List<TVSeriesModel>.from((json["results"] as List)
              .map((e) => TVSeriesModel.fromJson(e))
              .where((element) => element.posterPath != null))
  );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeries.map((x) => x.toJson())),
      };
  
  @override
  List<Object?> get props => [tvSeries];
}