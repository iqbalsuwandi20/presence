import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async {
    if (nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await firestore.collection("pegawai").doc(uid).update({
          "name": nameC.text,
        });

        Get.back();
        Get.snackbar("BERHASIL", "Anda berhasil mengganti profil");
      } catch (e) {
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat mengganti profil anda!");
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Data tidak boleh kosong");
    }
  }
}
