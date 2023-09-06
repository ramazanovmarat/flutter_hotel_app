import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/exception.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/platform/network_info.dart';
import 'package:hotel/feature/data/datasources/hotel_remote_data_source.dart';
import 'package:hotel/feature/data/models/hotel_models.dart';
import 'package:hotel/feature/domain/entities/hotel_entity.dart';
import 'package:hotel/feature/domain/repository/hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HotelRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, HotelEntity>> getHotels() async {
    return await _getHotels(() {
      return remoteDataSource.getHotels();
    });
  }

  Future<Either<Failure, HotelModel>> _getHotels(Future<HotelModel> Function() getHotels) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHotel = await getHotels();
        return Right(remoteHotel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}