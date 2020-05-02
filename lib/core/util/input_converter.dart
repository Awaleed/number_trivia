import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedIntger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw InvaildInputFailuer();
      return Right(integer);
    } catch (e) {
      return Left(InvaildInputFailuer());
    }
  }
}

class InvaildInputFailuer extends Failure {}
