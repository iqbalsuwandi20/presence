import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "admin123") {
        isLoading.value = true;
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );

          Get.offAllNamed(Routes.HOME);

          Get.snackbar('BERHASIL',
              "Berhasil mengganti kata sandi, dan selamat datang kembali ${auth.currentUser!.email}");

          isLoading.value = false;
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          if (e.code == "weak-password") {
            Get.snackbar("TERJADI KESALAHAN",
                "Kata Sandi anda terlalu lemah, harus 6 karakter");
          }
        } catch (e) {
          isLoading.value = false;
          Get.snackbar(
              "TERJADI KESALAHAN", "Tidak dapat mengganti kata sandi anda");
        }
      } else {
        isLoading.value = false;
        Get.snackbar("TERJADI KESALAHAN",
            "Tidak boleh menggunakan Kata Sandi 'admin123'");
      }
    } else {
      isLoading.value = false;
      Get.snackbar('TERJADI KESALAHAN', "Kata Sandi wajib di isi");
    }
  }
}
