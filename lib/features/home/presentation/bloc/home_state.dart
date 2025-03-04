import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLogoutInProgress extends HomeState {}

class HomeLogoutSuccess extends HomeState {}

class HomeLogoutFailure extends HomeState {
  final String error;

  const HomeLogoutFailure(this.error);

  @override
  List<Object?> get props => [error];
}
