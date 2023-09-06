import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/domain/entities/hotel_entity.dart';

abstract class HotelRepository {
  Future<Either<Failure, HotelEntity>> getHotels();
}