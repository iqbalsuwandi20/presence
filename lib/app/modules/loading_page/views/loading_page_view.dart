import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/loading_page_controller.dart';

class LoadingPageView extends GetView<LoadingPageController> {
  const LoadingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Center(
        child: Lottie.asset("assets/lotties/waiting.json"),
      ),
    );
  }
}
