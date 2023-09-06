import 'package:equatable/equatable.dart';
import 'package:hotel/feature/domain/entities/booking_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingEmpty extends BookingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingLoading extends BookingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingLoaded extends BookingState {
  final BookingEntity bookingEntity;

  const BookingLoaded(this.bookingEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [bookingEntity];
}

class BookingError extends BookingState {
  final String message;

  const BookingError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}