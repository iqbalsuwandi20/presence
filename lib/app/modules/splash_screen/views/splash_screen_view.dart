import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.startSplash();
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Center(
        child: Lottie.asset("assets/lotties/splash.json"),
      ),
    );
  }
}
