import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoadingEmailVerified = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            DocumentSnapshot userData = await firestore
                .collection('pegawai')
                .doc(userCredential.user!.uid)
                .get();

            String userName = userData['name'];

            isLoading.value = false;
            if (passC.text == "admin123") {
              Get.offAllNamed(Routes.NEW_PASSWORD);

              Get.snackbar(
                  "TERJADI KESALAHAN", "Anda harus mengganti kata sandi anda!");
            } else {
              Get.offAllNamed(Routes.HOME);

              Get.snackbar("BERHASIL", "Selamat datang kembali, $userName");
            }
          } else {
            isLoading.value = true;
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
                          isLoading.value = false;
                        } catch (e) {
                          isLoading.value = false;
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
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == "user-not-found") {
          Get.snackbar("TERJADI KESALAHAN", "Email tidak terdaftar");
        } else if (e.code == "wrong-password") {
          Get.snackbar(
              "TERJADI KESALAHAN", "Kata sandi yang Anda gunakan salah");
        } else {
          Get.snackbar(
              "TERJADI KESALAHAN", "Email dan Kata sandi anda tidak cocok!");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat masuk: ${e.toString()}");
      }
    } else {
      Get.snackbar(
          "TERJADI KESALAHAN", "Email dan Kata Sandi tidak boleh kosong");
    }
  }
}
