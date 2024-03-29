import 'tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvSeries;

  TvSeriesResponse({required this.tvSeries});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
          tvSeries: List<TvSeriesModel>.from((json["results"] as List)
              .map((x) => TvSeriesModel.fromJson(x))
              .where((element) => element.posterPath != null))
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeries.map((x) => x.toJson()))
      };

  @override
  List<Object?> get props => [tvSeries];
}