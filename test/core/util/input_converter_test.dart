import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedIntger', () {
    test(
      'should return an integer when the string represents an unsigned intgeer',
      () async {
        final str = '123';
        final result = inputConverter.stringToUnsignedIntger(str);
        expect(result, Right(123));
      },
    );
    test(
      'should return a failure when the string is not an intgeer',
      () async {
        final str = 'abc';
        final result = inputConverter.stringToUnsignedIntger(str);
        expect(result, Left(InvaildInputFailuer()));
      },
    );
    test(
      'should return a failure when the string is negative intgeer',
      () async {
        final str = '-123';
        final result = inputConverter.stringToUnsignedIntger(str);
        expect(result, Left(InvaildInputFailuer()));
      },
    );
  });
}
