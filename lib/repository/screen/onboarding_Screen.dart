import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales/repository/screen/signin_screen.dart';
import 'package:sales/repository/widgets/cust_buttons.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              width: MediaQuery.sizeOf(context).width * 0.9,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/banner/onboard.jpg'),
                      fit: BoxFit.fitWidth)),
            ),
            Positioned(
              bottom: 40,
              right: 60,
              child: Container(
                width: 280,
                height: 55,
                child: CustButtons(
                    bgColor: Color(0xFF2C2C2C),
                    text: "Get Started...!",
                    onPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninScreen()));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
