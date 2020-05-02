import 'dart:convert';

import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';

import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientCode200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientCode400() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('something went wrong', 400));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      '''should perform a GET request on a URL with number 
         being the endponit and with application/json header''',
      () async {
        setUpMockHttpClientCode200();

        dataSource.getConcreteNumberTrivia(tNumber);

        verify(mockHttpClient.get('http://numbersapi.com/$tNumber',
            headers: {'Content-Type': 'application/json'}));
      },
    );

    test(
      'should return a NumberTrivia when response code 200',
      () async {
        setUpMockHttpClientCode200();
        final result = await dataSource.getConcreteNumberTrivia(tNumber);

        expect(result, equals(tNumberTriviaModel));
      },
    );
    test(
      'should throw a ServerException when response code is not 200',
      () async {
        setUpMockHttpClientCode400();
        final call = dataSource.getConcreteNumberTrivia;

        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      '''should perform a GET request on a URL with random 
         being the endponit and with application/json header''',
      () async {
        setUpMockHttpClientCode200();

        dataSource.getRandomNumberTrivia();

        verify(mockHttpClient.get('http://numbersapi.com/random',
            headers: {'Content-Type': 'application/json'}));
      },
    );

    test(
      'should return a NumberTrivia when response code 200',
      () async {
        setUpMockHttpClientCode200();
        final result = await dataSource.getRandomNumberTrivia();

        expect(result, equals(tNumberTriviaModel));
      },
    );
    test(
      'should throw a ServerException when response code is not 200',
      () async {
        setUpMockHttpClientCode400();
        final call = dataSource.getRandomNumberTrivia;

        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
