import 'package:equatable/equatable.dart';
import 'package:hotel/feature/domain/entities/hotel_entity.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HotelEmpty extends HotelState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HotelLoading extends HotelState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HotelLoaded extends HotelState {
  final HotelEntity hotelEntityLoaded;

  const HotelLoaded(this.hotelEntityLoaded);

  @override
  // TODO: implement props
  List<Object?> get props => [hotelEntityLoaded];
}

class HotelError extends HotelState {
  final String message;

  const HotelError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}


