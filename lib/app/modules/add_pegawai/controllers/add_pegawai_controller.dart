import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        // ignore: avoid_print
        print(userCredentialAdmin);

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
            "job": jobC.text,
            "uid": uid,
            "role": "pegawai",
            "createdAt": DateTime.now().toIso8601String(),
          });

          await userCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          // ignore: avoid_print
          print(userCredentialAdmin);

          Get.back();
          Get.back();

          Get.snackbar("BERHASIL", "Berhasil membuat akun pegawai");
        }
        isLoadingAddPegawai.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == "weak-password") {
          Get.snackbar("TERJADI KESALAHAN",
              "Kata sandi yang anda ingin gunakan terlalu lemah");
        } else if (e.code == "email-already-in-use") {
          Get.snackbar("TERJADI KESALAHAN",
              "Email ini sudah terdaftar, mohon gunakan email yang lain");
        } else if (e.code == "wrong-password") {
          Get.snackbar("TERJADI KESALAHAN", "Kata sandi anda salah!");
        } else {
          Get.snackbar("TERJADI KESALAHAN", e.code);
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat membuat akun pegawai");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Kata sandi harus diisi");
    }
  }

  Future<void> addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        jobC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            Text("Masukan kata sandi untuk validasi admin"),
            TextField(
              controller: passAdminC,
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.green[900],
              decoration: InputDecoration(
                icon: Icon(Icons.password_outlined, color: Colors.green[900]),
                labelText: "Kata Sandi",
                labelStyle: TextStyle(color: Colors.green[900]),
              ),
            ),
          ],
        ),
        actions: [
          Obx(
            () {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900]),
                  onPressed: () async {
                    if (isLoadingAddPegawai.isFalse) {
                      await prosesAddPegawai();
                      isLoading.value = false;
                    }
                  },
                  child: Text(
                    isLoadingAddPegawai.isFalse
                        ? "TAMBAH PEGAWAI"
                        : "TUNGGU YA..",
                    style: TextStyle(color: Colors.white),
                  ));
            },
          ),
        ],
      );
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Semua data harus di isi");
    }
  }
}
