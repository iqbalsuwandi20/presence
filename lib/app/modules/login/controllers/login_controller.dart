import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar("TERJADI KESALAHAN",
                "Mohon cek kotak email anda untuk melakukan verifikasi");
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "Pengguna tidak ditemukan") {
          Get.snackbar("TERJADI KESALAHAN", "Email tidak terdaftar");
        } else if (e.code == "Kata sandi salah") {
          Get.snackbar(
              "TERJADI KESALAHAN", "Kata sandi yang ada gunakan salah");
        }
      } catch (e) {
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat masuk");
      }
    } else {
      Get.snackbar(
          "TERJADI KESALAHAN", "Email dan Kata Sandi tidak boleh kosong");
    }
  }
}
