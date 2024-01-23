import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final genreModel = GenreModel(
    id: 1,
    name: "Genre 1"
  );

  final entity = Genre(
    id: 1,
    name: "Genre 1"
  );

  test('should be a subclass of Genre entity', () async {
    final result = genreModel.toEntity();
    expect(result, entity);
  });
}
