import 'package:equatable/equatable.dart';
import 'package:hotel/feature/domain/entities/selection_number_entity.dart';

abstract class NumberState extends Equatable {
  const NumberState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NumberEmpty extends NumberState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NumberLoading extends NumberState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NumberlLoaded extends NumberState {
  final List<SelectionNumberEntity> numberEntity;

  const NumberlLoaded(this.numberEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [numberEntity];
}

class NumberError extends NumberState {
  final String message;

  const NumberError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}