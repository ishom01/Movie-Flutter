import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class EpisodeResponse extends Equatable {
  final List<EpisodeModel> episodes;

  EpisodeResponse({required this.episodes});

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
          episodes: List<EpisodeModel>.from((json["episodes"] as List)
              .map((x) => EpisodeModel.fromJson(x)))
      );

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson()))
      };

  @override
  List<Object?> get props => [episodes];
}