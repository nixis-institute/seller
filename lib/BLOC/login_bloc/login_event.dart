part of 'login_bloc.dart';



abstract class AuthenticateEvent extends Equatable{
  const AuthenticateEvent();
}
class AppStarted extends AuthenticateEvent{
  @override
  List<Object> get props => null;
}

class OnIsAuthentication extends AuthenticateEvent{
  @override
  List<Object> get props => null;
}
class OnAuthenticated extends AuthenticateEvent{
  @override
  List<Object> get props =>null;
}
class LoggedOut extends AuthenticateEvent{
  @override
  List<Object> get props =>null;  
}


abstract class LoginEvent extends Equatable {
  const LoginEvent();
}


class InitialLogin extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class OnLogin extends LoginEvent{
  String username;
  String password;
  OnLogin(this.username,this.password);
  @override  
  List<Object> get props => null;
}


class OnLogout extends LoginEvent{
  @override  
  List<Object> get props => null;
}