import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assignment_zarity_health/pages/body_page.dart';
import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen {
  static Widget returnPrimarySplashScreen(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: 'assets/zarity-logo-white.png',
      nextScreen: const BlogPage(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: ThemeUtils.foregroundThemeColor.withOpacity(0.970),
    );
  }
}