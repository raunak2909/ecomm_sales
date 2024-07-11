import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/data/remote/api_helper.dart';
import 'package:sales/repository/screen/login/bloc/login_bloc.dart';
import 'package:sales/repository/screen/login/ui/signin_screen.dart';
import 'package:sales/repository/screen/onboarding_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => LoginBloc(apiHelper: ApiHelper()),
          child: SigninScreen(),
        ));
  }
}
