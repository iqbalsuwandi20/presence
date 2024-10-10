import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController passC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (passC.text.isNotEmpty &&
        newPassC.text.isNotEmpty &&
        confirmNewPassC.text.isNotEmpty) {
      if (newPassC.text == confirmNewPassC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: passC.text);

          await auth.currentUser!.updatePassword(newPassC.text);

          Get.back();

          Get.snackbar("BERHASIL",
              "Anda sudah berhasil mengganti kata sandi, silahkan masuk dengan kata sandi baru!!");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("TERJADI KESALAHAN",
                "Kata sandi yang anda gunakan sekarang salah!");
          } else {
            Get.snackbar('TERJADI KESALAHAN', e.code.toString());
          }
        } catch (e) {
          Get.snackbar(
              "TERJADI KESALAHAN", "Tidak dapat mengganti kata sandi anda!!");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("TERJADI KESALAHAN", "Kata sandi anda harus sesuai!");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Data tidak boleh kosong");
    }
  }
}
