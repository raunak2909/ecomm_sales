import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/repository/screen/home/ui/homescreen.dart';
import 'package:sales/repository/screen/login/bloc/login_bloc.dart';
import 'package:sales/repository/screen/login/ui/signup_screen.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/cust_buttons.dart';
import '../../../widgets/cust_tf_inputdecoration.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => SigninScreenState();
}

class SigninScreenState extends State<SigninScreen> {
  bool isHidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Sign in",
                style: mFontStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "Login your account",
                style: mFontStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              mSpacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Colors.white24,
                      )
                    ]),
                child: Column(
                  children: [
                    mSpacer(),

                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: mInputDecoration(
                          hText: "Email", preIcon: Icon(Icons.email_outlined)),
                    ),
                    mSpacer(),
                    TextField(
                      obscureText: isHidePass,
                      decoration: mInputDecoration(
                          hText: "Password",
                          preIcon: Icon(Icons.lock_outline_rounded),
                          suIcon: IconButton(
                              onPressed: () {
                                isHidePass = !isHidePass;
                                setState(() {});
                              },
                              icon: isHidePass
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.remove_red_eye_outlined))),
                    ),
                    mSpacer(),

                    /// Sign up Button
                    Container(
                        height: 45,
                        width: 220,
                        child: BlocListener<LoginBloc, LoginState>(
                          listener: (_, state){
                            if(state is LoginLoadingState){
                              ///show snackbar
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  mSpacer(),
                                  Text('Logging - in...')
                                ],
                              )));

                            } else if(state is LoginSuccessState){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged in Successfully!!')));
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ));
                            } else if(state is LoginFailedState){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${state.errorMsg}')));
                            }
                          },
                          child: CustButtons(text: "Login", onPress: () {
                            /*context.read<LoginBloc>().add(LoginUser(email: e, pass: pass));
                            BlocProvider.of<LoginBloc>(context, listen: false).add(LoginUser(email: e, pass: pass));*/

                          })),
                    ),
                    mSpacer(),
                    Text(
                      'or',
                      style: mFontStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignupScreen();
                                },
                              ));
                            },
                            child: Text(
                              'Create a new account..!',
                              style: mFontStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mSpacer({double mheight = 16}) {
    return SizedBox(
      height: mheight,
    );
  }
}
