import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/login_bloc/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent,AuthenticateState>{
  LoginRepostory repository;
  
  AuthenticateBloc(this.repository);
  
  @override
  AuthenticateState get initialState => AuthenticateInital();
  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async*{
    if(event is AppStarted){
      print("inital");
      final token = await repository.hasToken();
      yield token?Authenticated():NotAuthenticated();
    }
    if(event is LoggedOut){
      await repository.removeToken();
      yield NotAuthenticated();
    }
    if(event is OnAuthenticated){
      yield Authenticated();
    }

  }
}


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepostory repository;
  AuthenticateBloc authenticateBloc;
  LoginBloc({this.repository, this.authenticateBloc});
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is InitialLogin)
    {
      bool isAuthenticated = await repository.hasToken();
      yield IsAuthenticated(isAuthenticated);
    }
    if(event is OnLogin)
    {
      yield LoginLoading();
      var token = await repository.login(event.username, event.password);
      if(token!=null){
        // print("sdlkfjsdlkfjklsdjfklsdjlkfjdslkfjlkdsjf");
        print(token);
        authenticateBloc.add(
          OnAuthenticated()
        );
      }

      yield token==null?LoginFailure():LoginSuccess();
    
    }
    if(event is OnLogout){
      repository.removeToken();
      yield IsAuthenticated(false);
    }

    // TODO: implement mapEventToState
  }
}
