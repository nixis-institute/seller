import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_junction_seller/BLOC/Bloc/Authentication_bloc.dart';
import 'package:shopping_junction_seller/BLOC/Bloc/login_bloc.dart';
import 'package:shopping_junction_seller/BLOC/event/login_event.dart';
import 'package:shopping_junction_seller/BLOC/state/login_state.dart';
import 'package:shopping_junction_seller/functions/requestLogin.dart';
import 'package:shopping_junction_seller/BLOC/repository/UserRepository.dart';

class LoginScreen extends StatefulWidget{
  final UserRepository userRepository;
  @override
    LoginScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);
  _LoginScreen createState() =>_LoginScreen();
}



class _LoginScreen extends State<LoginScreen>
{
  final _User = TextEditingController();
  final _Pass = TextEditingController();




  @override
  bool isPasswordVisible = false;
  bool isWrong = false;
  bool isSubmit  = false;
  void initState()
  {
    super.initState();
  }
    _sendToServer(context,username,password)
      async {
        var x = await requestLoginApi(username,password);
        if(x==null){
          setState(() {
            isWrong = true;
            isSubmit = false;
          });
        }
        else{
          
          // Navigator.pop(context);

        }

      }  

  Widget _userName()
  {
    return Column(
      children: <Widget>[
      isWrong?
      Text('Wrong username or password',style: TextStyle(color: Colors.red),):
      SizedBox(height: 1,),
      TextFormField(
        controller: _User,
        decoration: InputDecoration(
          // border: InputBord
          hintText: 'Username',
          labelText: 'Username'
        ),
        onTap: (){
          setState(() {
            isWrong = false;
          });
        },                            
      ),
      ],
    );
  }

  Widget _passWord()
  {
    return Column(
      children: <Widget>[
      TextFormField(
        autofocus: false,
        controller: _Pass,
        // onChanged: ,
        decoration: InputDecoration(
          // border: InputBord
          hintText: 'Password',
          labelText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(isPasswordVisible?Icons.visibility:Icons.visibility_off),
            onPressed: (){
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          
        ),
        onTap: (){
          setState(() {
            isWrong = false;
          });
        },

        obscureText: !isPasswordVisible,
          ),
      ],
    );
  }




  Widget build(BuildContext context){

    _onLoginButtonPressed(context) {
      // BlocProvider.of(context)
      print(_User.text);
      print(_Pass.text);
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _User.text,
          password: _Pass.text,
        ),
      );
    }

    return Scaffold(
        body: BlocProvider(
            create: (context){
              return LoginBloc(userRepository: this.widget.userRepository, authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
            },
            child: BlocBuilder<LoginBloc,LoginState>(
              builder: (context,state){
                return Container(
                padding: EdgeInsets.only(left:20,right:20),
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // scrollDirection: Axis.vertical,
                  children: <Widget>[
                      SizedBox(height:MediaQuery.of(context).size.height*0.2),
                      Text("Login",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),
                      SizedBox(height:10),
                      state is LoginFailure?
                      Text("wrong username or password"):SizedBox(),
                      _userName(),
                      SizedBox(height: 10,),
                      _passWord(),

                      SizedBox(height: 20,), 

                      InkWell(
                        onTap: (){
                            setState(() {
                              isSubmit = true;
                            });
                            _onLoginButtonPressed(context);
                          // _sendToServer(context,_User.text,_Pass.text);
                          // state is!LoginLoading? _onLoginButtonPressed:null;
                        },
                          child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius :BorderRadius.circular(30),
                          ),
                          child: 
                          
                          state is LoginLoading
                          ?Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(strokeWidth: 3,valueColor: AlwaysStoppedAnimation(Colors.white),),)
                          :Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 19),),
                        ),
                      ),                
                  ],
                ),
              );                
              },
            )
            
            
,
        
        ),
    );
  }
}