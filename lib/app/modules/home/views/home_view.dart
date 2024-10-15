import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/page_index_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final pageC = Get.find<PageIndexController>();

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
          StreamBuilder(
            stream: controller.streamPictureProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                  backgroundColor: Colors.grey,
                );
              }

              Map<String, dynamic>? user = snapshot.data!.data();

              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(user?["profile"] != null
                      ? user!["profile"]
                      : "https://ui-avatars.com/api/?name=${user!["name"]}"),
                ),
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.green[900],
        items: [
          TabItem(icon: Icons.home, title: 'Halaman Utama'),
          TabItem(icon: Icons.fingerprint, title: 'Sidik Jari'),
          TabItem(icon: Icons.people, title: 'Profil'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
