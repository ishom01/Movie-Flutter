import 'package:core/data/models/episode_model.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final episodeModel = EpisodeModel(
    airDate: "1999-01-31",
    episodeNumber: 1,
    episodeType: "standard",
    id: 66050,
    name: "Episode 1",
    overview: "Description episode 1",
    productionCode: "1ACX01",
    runtime: 22,
    seasonNumber: 1,
    showId: 1434,
    stillPath: "/z9Jd3tN6lclBKhap2xC2Ttq7PPf.jpg",
    voteAverage: 6.94,
    voteCount: 50
  );

  final entity = Episode(
    airDate: "1999-01-31",
    episodeNumber: 1,
    episodeType: "standard",
    id: 66050,
    name: "Episode 1",
    overview: "Description episode 1",
    productionCode: "1ACX01",
    runtime: 22,
    seasonNumber: 1,
    showId: 1434,
    stillPath: "/z9Jd3tN6lclBKhap2xC2Ttq7PPf.jpg",
    voteAverage: 6.94,
    voteCount: 50
  );

  test('should be a subclass of Episode entity', () async {
    final result = episodeModel.toEntity();
    expect(result, entity);
  });
}
