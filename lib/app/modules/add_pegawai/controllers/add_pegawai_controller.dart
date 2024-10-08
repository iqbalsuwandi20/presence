import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

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
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await userCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          print(userCredentialAdmin);

          Get.back();
          Get.back();

          Get.snackbar("BERHASIL", "Berhasil membuat akun pegawai");
        }
      } on FirebaseAuthException catch (e) {
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
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat membuat akun pegawai");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Kata sandi harus diisi");
    }
  }

  void addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
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
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
              onPressed: () async {
                await prosesAddPegawai();
              },
              child: Text(
                "TAMBAH PEGAWAI",
                style: TextStyle(color: Colors.white),
              ))
        ],
      );
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Semua data harus di isi");
    }
  }
}
