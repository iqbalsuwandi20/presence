import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      update();
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Anda harus memilih foto");
    }
  }

  Future<void> updateProfile(String uid) async {
    if (nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref("$uid/profile.$ext").putFile(file);
          String urlImage =
              await storage.ref("$uid/profile.$ext").getDownloadURL();

          data.addAll({"profile": urlImage});
        }
        await firestore.collection("pegawai").doc(uid).update(data);

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
