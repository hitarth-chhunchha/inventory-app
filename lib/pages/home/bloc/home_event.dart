part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}


class LoadUsers extends HomeEvent {}

class RefreshUsers extends HomeEvent {}

class FilterUsers extends HomeEvent {
  final String query;

  const FilterUsers(this.query);

  @override
  List<Object> get props => [query];
}

class UpdateRupee extends HomeEvent {
  final int userId;
  final int newRupee;

  const UpdateRupee({required this.userId, required this.newRupee});

  @override
  List<Object> get props => [userId, newRupee];
}
