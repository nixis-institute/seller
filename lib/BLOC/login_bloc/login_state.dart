part of 'login_bloc.dart';

@immutable
abstract class AuthenticateState extends Equatable {}

class AuthenticateInital extends AuthenticateState{
  List<Object> get props => [];
}

class Authenticated extends AuthenticateState{
  List<Object> get props => [];
} 

class NotAuthenticated extends AuthenticateState{
  @override
  List<Object> get props => [];
}





abstract class LoginState extends Equatable {
  const LoginState();
}


class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class IsAuthenticated extends LoginState{
  bool isAuthenticated;
  IsAuthenticated(this.isAuthenticated);
  @override
  List<Object> get props => [];
}



class LoginSuccess extends LoginState{
  LoginSuccess();
  @override
  List<Object> get props => [];
}
class LoginFailure extends LoginState{
  LoginFailure();  
  @override
  List<Object> get props => [];
}


class LoginLoading extends LoginState{
  List<Object> get props => [];
}