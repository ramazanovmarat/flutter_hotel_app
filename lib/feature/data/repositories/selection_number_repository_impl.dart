import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/exception.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/platform/network_info.dart';
import 'package:hotel/feature/data/datasources/selction_number_remote_data_source.dart';
import 'package:hotel/feature/data/models/selection_number_models.dart';
import 'package:hotel/feature/domain/entities/selection_number_entity.dart';
import 'package:hotel/feature/domain/repository/selection_number_repositoty.dart';

class SelectionNumberRepositoryImpl implements SelectionNumberRepository {
  final SelectionNumberDataSource selectionNumberDataSource;
  final NetworkInfo networkInfo;

  SelectionNumberRepositoryImpl({required this.selectionNumberDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<SelectionNumberEntity>>> getNumbers() async {
    return await _getNumbers(() {
      return selectionNumberDataSource.getNumbers();
    });
  }

  Future<Either<Failure, List<SelectionNumberModel>>> _getNumbers(Future<List<SelectionNumberModel>> Function() fetchNumbers) async {
    if(await networkInfo.isConnected) {
      try {
        final remoteHotel = await fetchNumbers();
        return Right(remoteHotel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}