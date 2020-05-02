import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:number_trivia/core/network/network_info.dart';

class MockDataconnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataconnectionChecker mockDataconnectionChecker;
  NetworkInfoImpl networkInfo;

  setUp(() {
    mockDataconnectionChecker = MockDataconnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataconnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        final tHasConnectionFuture = Future.value(true);

        when(mockDataconnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);

        final result = networkInfo.isConnected;

        verify(mockDataconnectionChecker.hasConnection);

        expect(result, tHasConnectionFuture);
      },
    );
  });
}
