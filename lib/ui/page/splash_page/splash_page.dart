import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover,
                image: AssetImage('assets/images/splash_background.png'))),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    SizedBox(
                      height: 30,
                    ),
                    Text("pubg_arena".tr())
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Image.asset('assets/images/future_development_logo.png'),Image.asset('assets/images/soft_club_logo.png')],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
