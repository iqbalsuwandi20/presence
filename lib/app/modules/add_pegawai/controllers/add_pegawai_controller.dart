import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "admin123",
        );

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await userCredential.user!.sendEmailVerification();

          Get.back();

          Get.snackbar("BERHASIL", "Berhasil membuat akun pegawai");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "Kata sandi terlalu lemah") {
          Get.snackbar("TERJADI KESALAHAN",
              "Kata sandi yang anda ingin gunakan terlalu lemah");
        } else if (e.code == "email sudah terpakai") {
          Get.snackbar("TERJADI KESALAHAN",
              "Email ini sudah terdaftar, mohon gunakan email yang lain");
        }
      } catch (e) {
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat membuat akun pegawai");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Semua data harus di isi");
    }
  }
}
