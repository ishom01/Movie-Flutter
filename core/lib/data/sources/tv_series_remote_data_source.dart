import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/exception.dart';
import '../models/episode_model.dart';
import '../models/episode_response.dart';
import '../models/tv_series_detail_model.dart';
import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingSeries();
  Future<List<TvSeriesModel>> getPopularSeries();
  Future<List<TvSeriesModel>> getTopRatedSeries();
  Future<TvSeriesDetailResponse> getSeriesDetail(int id);
  Future<List<TvSeriesModel>> getSeriesRecommendations(int id);
  Future<List<EpisodeModel>> getEpisodes(int id, int season);
  Future<List<TvSeriesModel>> searchSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getNowPlayingSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getSeriesDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeries;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodes(int id, int season) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id}/season/$season}?$API_KEY'));

    if (response.statusCode == 200) {
      return EpisodeResponse.fromJson(json.decode(response.body)).episodes;
    } else {
      throw ServerException();
    }
  }
}
