import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/domain/entities/selection_number_entity.dart';

abstract class SelectionNumberRepository {
  Future<Either<Failure, List<SelectionNumberEntity>>> getNumbers();
}