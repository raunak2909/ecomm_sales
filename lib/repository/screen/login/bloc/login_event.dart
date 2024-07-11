part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


class LoginUser extends LoginEvent{
  String email;
  String pass;
  LoginUser({required this.email, required this.pass});
}


