import '../../common/exception.dart';
import '../../common/home_enum.dart';
import '../db/database_helper.dart';
import '../models/movie_table.dart';

abstract class WatchListLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable movie);
  Future<String> removeWatchlist(WatchlistTable movie);
  Future<WatchlistTable?> getWatchListById(int id, DataType type);
  Future<List<WatchlistTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements WatchListLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getWatchListById(int id, DataType type) async {
    final result = await databaseHelper.getWatchlistById(id, type);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
