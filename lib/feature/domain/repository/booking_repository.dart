import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, BookingEntity>> getBooking();
}