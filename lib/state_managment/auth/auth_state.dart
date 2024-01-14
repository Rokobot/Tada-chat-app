part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}


class AuthLoadingState extends AuthState {}


class AuthSuccesState extends AuthState {}


class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
