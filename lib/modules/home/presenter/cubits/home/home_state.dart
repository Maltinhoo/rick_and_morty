part of 'home_cubit.dart';

abstract class HomeState {
  final GenderEnum? gender;
  final SpeciesEnum? specie;
  final StatusEnum? status;

  HomeState({this.gender, this.specie, this.status});
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final PagingState<int, CharacterEntity> pagingState;

  HomeLoaded(this.pagingState, {super.gender, super.specie, super.status});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
