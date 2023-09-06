import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/usecases/usecase.dart';
import 'package:hotel/feature/domain/entities/hotel_entity.dart';
import 'package:hotel/feature/domain/repository/hotel_repository.dart';

class GetHotels extends UseCase<HotelEntity> {
  final HotelRepository hotelRepository;

  GetHotels(this.hotelRepository);

  @override
  Future<Either<Failure, HotelEntity>> call() async {
    return await hotelRepository.getHotels();
  }
}