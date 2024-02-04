import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final genreModel  = GenreModel(
      id: 1,
      name: "Genre 1",
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = genreModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "Genre 1",
      };
      expect(result, expectedJsonMap);
    });
  });
}
