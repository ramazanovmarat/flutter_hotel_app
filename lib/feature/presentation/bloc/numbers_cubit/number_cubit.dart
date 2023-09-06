import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/domain/usecases/get_numbers.dart';
import 'package:hotel/feature/presentation/bloc/numbers_cubit/numbers_state.dart';

class NumberCubit extends Cubit<NumberState> {
  final GetNumbers getNumbers;

  NumberCubit({required this.getNumbers}) : super(NumberEmpty());

  void loadNumbers() async {
    if(state is NumberLoading) return;

    emit(NumberLoading());

    final failureOrNumbers = await getNumbers();

    failureOrNumbers.fold(
            (error) => emit(NumberError(message: _failureToMessage(error))),
            (numbers) {
          emit(NumberlLoaded(numbers));
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