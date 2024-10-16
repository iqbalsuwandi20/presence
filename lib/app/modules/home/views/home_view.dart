import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            width: 15,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  width: 75,
                  height: 75,
                  color: Colors.grey[400],
                  child: Center(
                    child: Text("Test"),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Jl. Mandor Masan",
                    style: TextStyle(color: Colors.green[900]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Developer",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "2472468",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Iqbal Suwandi",
                  style: TextStyle(color: Colors.green[900]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Masuk",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "-",
                      style: TextStyle(color: Colors.green[900]),
                    ),
                  ],
                ),
                Container(
                  width: 5,
                  height: 50,
                  color: Colors.green[900],
                ),
                Column(
                  children: [
                    Text(
                      "Keluar",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "-",
                      style: TextStyle(color: Colors.green[900]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 5,
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "5 Hari terakhir",
                style: TextStyle(
                  color: Colors.green[900],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Liat Nanti",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Masuk",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.jms().format(DateTime.now()),
                      style: TextStyle(color: Colors.green[900]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Keluar",
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.jms().format(DateTime.now()),
                      style: TextStyle(color: Colors.green[900]),
                    ),
                  ],
                ),
              );
            },
          )
        ],
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
