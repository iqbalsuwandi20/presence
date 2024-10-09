import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: Colors.green[900],
        title: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamNameAppbar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: Colors.white);
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              return Text(
                "Hai, ${user["name"] ?? "User"}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              );
            } else {
              return const Text(
                "Tidak dapat memuat data anda!",
                style: TextStyle(color: Colors.white),
              );
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            ),
          ),
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
                ? const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.clean_hands_outlined,
                    color: Colors.white,
                  ),
          );
        },
      ),
    );
  }
}
