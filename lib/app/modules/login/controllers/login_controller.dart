import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

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
            if (passC.text == "admin123") {
              Get.offAllNamed(Routes.NEW_PASSWORD);

              Get.snackbar(
                  "TERJADI KESALAHAN", "Anda harus mengganti kata sandi anda!");
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "TERJADI KESALAHAN",
                middleText:
                    "Mohon cek kotak email anda untuk melakukan verifikasi",
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900]),
                      onPressed: () async {
                        try {
                          await userCredential.user!.sendEmailVerification();

                          Get.back();

                          Get.snackbar("BERHASIL",
                              "Sudah dikirim ke email anda, mohon di cek!");
                        } catch (e) {
                          Get.snackbar("TERJADI KESALAHAN",
                              "Tidak dapat mengirim email verifikasi. Mohon tulis email anda dengan benar");
                        }
                      },
                      child: Text(
                        "KIRIM ULANG EMAIL",
                        style: TextStyle(color: Colors.white),
                      )),
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          Get.snackbar("TERJADI KESALAHAN", "Email tidak terdaftar");
        } else if (e.code == "wrong-password") {
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
