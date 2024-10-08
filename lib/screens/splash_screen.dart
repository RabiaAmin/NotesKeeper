import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_keeper_app/helpers/routes.dart';
import 'package:notes_keeper_app/helpers/sizeConfig.dart';

import '../hiveServices/onbordeing_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnboardingService _onboardingService = OnboardingService();

  @override
  void initState() {
    super.initState();

    // Set a delay for 3 seconds before navigating to the next screen
    Timer(Duration(seconds: 2), () async {
      bool isOnboardingCompleted =
          await _onboardingService.isOnboardingCompleted();

      if (isOnboardingCompleted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
      }
    } // Navigate to the main app page
        );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
        child: Container(
      width: SizeConfig.blockW! * 100,
      height: SizeConfig.blockH! * 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffe55d87), Color(0xff5fc3e4)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: SizeConfig.blockH! * 18,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.edit_note_outlined,
              size: SizeConfig.blockH! * 16,
              color: Color(0xffe55d87),
            ),
            Text(
              "NOTES KEEPER",
              style: TextStyle(
                  color: Color(0xffe55d87),
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            )
          ]),
        ),
      ),
    ));
  }
}
