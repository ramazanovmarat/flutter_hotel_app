import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/domain/usecases/get_hotels.dart';
import 'package:hotel/feature/presentation/bloc/hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final GetHotels getHotels;

  HotelCubit({required this.getHotels}) : super(HotelEmpty());

  void loadHotel() async {
    if(state is HotelLoading) return;

    emit(HotelLoading());

    final failureOrHotel = await getHotels();

    failureOrHotel.fold(
            (error) => emit(HotelError(message: _failureToMessage(error))),
            (hotels) {
              emit(HotelLoaded(hotels));
            });

  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}