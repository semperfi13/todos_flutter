import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todos/app/data/album.dart';
import 'package:todos/app/utils/fetch.dart';
import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2')),
      ).thenAnswer((_) async =>
          http.Response('{"userId": 1, "id": 2, "title": "mockito"}', 200));

      final result = await fetchAlbum(client);
      print(result.title);
      expect(result, isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(
        client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2')),
      ).thenAnswer((_) async => http.Response('Not Found', 300));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
