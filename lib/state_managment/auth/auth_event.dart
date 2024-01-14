part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AuthSignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;
  final BuildContext context;

  AuthSignUpEvent({required this.email, required this.password, required this.context ,  required this.userName});

  @override
  List<Object> get props => [email, password, context, userName];
}


class AuthSignInEvent extends AuthEvent {


  final String email;
  final String password;
  final BuildContext context;

  AuthSignInEvent({required this.email, required this.password, required this.context,});

  @override
  List<Object> get props => [email, password];

}


