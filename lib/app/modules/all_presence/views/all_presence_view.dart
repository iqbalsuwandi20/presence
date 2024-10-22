import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_presence_controller.dart';

class AllPresenceView extends GetView<AllPresenceController> {
  const AllPresenceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SEMUA PRESENSI',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                autocorrect: false,
                cursorColor: Colors.green[900],
                decoration: InputDecoration(
                  labelText: "Cari presensi anda..",
                  labelStyle: TextStyle(color: Colors.green[900]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamAllPresence(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green[900],
                      ),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          "Belum ada riyawat absensi",
                          style: TextStyle(color: Colors.green[900]),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          snapshot.data!.docs[index].data();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Material(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_PRESENCE,
                                arguments: data,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      DateFormat.yMMMMEEEEd('id_ID')
                                          .format(DateTime.parse(data["date"])),
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
                                    data["masuk"]?["clock"] == null
                                        ? "-"
                                        : DateFormat.jms().format(
                                            DateTime.parse(
                                                data["masuk"]!["clock"])),
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
                                    data["keluar"]?["clock"] == null
                                        ? "-"
                                        : DateFormat.jms().format(
                                            DateTime.parse(
                                                data["keluar"]!["clock"])),
                                    style: TextStyle(color: Colors.green[900]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
