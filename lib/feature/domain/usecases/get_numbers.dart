import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/usecases/usecase.dart';
import 'package:hotel/feature/domain/entities/selection_number_entity.dart';
import 'package:hotel/feature/domain/repository/selection_number_repositoty.dart';

class GetNumbers extends UseCase<List<SelectionNumberEntity>> {
  final SelectionNumberRepository selectionNumberRepository;

  GetNumbers(this.selectionNumberRepository);

  @override
  Future<Either<Failure, List<SelectionNumberEntity>>> call() async {
    return await selectionNumberRepository.getNumbers();
  }
}