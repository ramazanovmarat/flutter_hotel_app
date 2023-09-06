import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/usecases/usecase.dart';
import 'package:hotel/feature/domain/entities/booking_entity.dart';
import 'package:hotel/feature/domain/repository/booking_repository.dart';

class GetBooking extends UseCase<BookingEntity> {
  final BookingRepository bookingRepository;

  GetBooking(this.bookingRepository);

  @override
  Future<Either<Failure, BookingEntity>> call() async {
    return await bookingRepository.getBooking();
  }
}