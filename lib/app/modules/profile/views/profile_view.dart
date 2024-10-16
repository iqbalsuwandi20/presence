import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/page_index_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROFIL',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: SizedBox(),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lotties/waiting.json"),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user["name"]}";
              return ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            user["profile"] != null
                                ? user["profile"] != ""
                                    ? user["profile"]
                                    : defaultImage
                                : defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    user["name"].toString().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    user["email"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Get.toNamed(
                        Routes.UPDATE_PROFILE,
                        arguments: user,
                      );
                    },
                    leading:
                        Icon(Icons.person_2_outlined, color: Colors.green[900]),
                    title: Text(
                      "Ganti Profil",
                      style: TextStyle(color: Colors.green[900]),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PASSWORD);
                    },
                    leading: Icon(Icons.vpn_key_off_outlined,
                        color: Colors.green[900]),
                    title: Text("Ganti Kata Sandi",
                        style: TextStyle(color: Colors.green[900])),
                  ),
                  if (user["role"] == "admin")
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.ADD_PEGAWAI);
                      },
                      leading: Icon(Icons.person_add_alt_1_outlined,
                          color: Colors.green[900]),
                      title: Text("Tambah Pegawai",
                          style: TextStyle(color: Colors.green[900])),
                    ),
                  ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    leading:
                        Icon(Icons.logout_outlined, color: Colors.green[900]),
                    title: Text("Keluar Aplikasi",
                        style: TextStyle(color: Colors.green[900])),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("Tidak dapat memuat data anda!",
                    style: TextStyle(color: Colors.green[900])),
              );
            }
          }),
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
