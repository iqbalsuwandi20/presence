import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomeView',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
              icon: Icon(
                Icons.person_add_alt,
                color: Colors.white,
              ))
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Obx(
        () {
          return FloatingActionButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                controller.isLoading.value = true;
                await FirebaseAuth.instance.signOut();
                controller.isLoading.value = false;

                Get.offAllNamed(Routes.LOGIN);

                Get.snackbar("BERHASIL",
                    "Anda berhasil keluar, silahkan masuk kembali!!");
              }
            },
            backgroundColor: Colors.green[900],
            child: controller.isLoading.isFalse
                ? Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.clean_hands_outlined,
                    color: Colors.white,
                  ),
          );
        },
      ),
    );
  }
}
