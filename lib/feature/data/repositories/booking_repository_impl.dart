import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/exception.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/platform/network_info.dart';
import 'package:hotel/feature/data/datasources/booking_remote_data_source.dart';
import 'package:hotel/feature/data/models/booking_models.dart';
import 'package:hotel/feature/domain/entities/booking_entity.dart';
import 'package:hotel/feature/domain/repository/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({required this.bookingRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, BookingEntity>> getBooking() async{
    return await _getHotels(() {
      return bookingRemoteDataSource.getBooking();
    });
  }

  Future<Either<Failure, BookingModels>> _getHotels(Future<BookingModels> Function() getBooking) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBooking = await getBooking();
        return Right(remoteBooking);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}