import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  void startSplash() {
    Future.delayed(
      Duration(seconds: 5),
      () {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      },
    );
  }
}
