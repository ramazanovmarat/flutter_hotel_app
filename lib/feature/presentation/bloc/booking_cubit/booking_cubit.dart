import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/domain/usecases/get_booking.dart';
import 'package:hotel/feature/presentation/bloc/booking_cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final GetBooking getBooking;

  BookingCubit({required this.getBooking}) : super(BookingEmpty());

  void loadBooking() async {
    if(state is BookingLoading) return;

    emit(BookingLoading());

    final failureOrBooking = await getBooking();

    failureOrBooking.fold(
            (error) => emit(BookingError(message: _failureToMessage(error))),
            (booking) => emit(BookingLoaded(booking)),
    );
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