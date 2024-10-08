import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmailResetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.back();

        Get.snackbar("BERHASIL",
            "Mohon cek kembali kotak email anda, karena sudah dikirim link untuk reset kata sandi!");
      } catch (e) {
        Get.snackbar("TERJADI KESALAHAN",
            "Tidak dapat mengirim link email untuk reset kata sandi");
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Data tidak boleh kosong");
    }
  }
}
