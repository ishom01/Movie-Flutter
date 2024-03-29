import 'package:core/data/sources/db/database_helper.dart';
import 'package:core/data/sources/movie_remote_data_source.dart';
import 'package:core/data/sources/watch_list_local_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  WatchListLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
