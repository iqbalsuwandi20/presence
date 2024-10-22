import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  DetailPresenceView({super.key});

  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETAIL KEHADIRAN',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Colors.green[900],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    DateFormat.yMMMMEEEEd('id_ID')
                        .format(DateTime.parse(data["date"]))
                        .toString()
                        .toUpperCase(),
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
                      ? "Jam: -"
                      : "Jam: ${DateFormat.jms().format(DateTime.parse(data["masuk"]!["clock"]))}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["masuk"]?["address"] == null
                      ? "Alamat: -"
                      : "Alamat: ${data["masuk"]!["address"]}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["masuk"]?["lat"] == null &&
                          data["masuk"]?["long"] == null
                      ? "Posisi: -"
                      : "Posisi: ${data["masuk"]!["lat"]}, ${data["masuk"]!["long"]}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["masuk"]?["distance"] == null
                      ? "Jarak: -"
                      : "Jarak: ${data["masuk"]!["distance"].toString().split(".").first} Meter",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["masuk"]?["status"] == null
                      ? "Status: -"
                      : "Status: ${data["masuk"]!["status"]}",
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
                      ? "Jam: -"
                      : "Jam: ${DateFormat.jms().format(DateTime.parse(data["keluar"]!["clock"]))}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["keluar"]?["address"] == null
                      ? "Alamat: -"
                      : "Alamat: ${data["keluar"]!["address"]}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["keluar"]?["lat"] == null &&
                          data["keluar"]?["long"] == null
                      ? "Posisi: -"
                      : "Posisi: ${data["keluar"]!["lat"]}, ${data["keluar"]!["long"]}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["keluar"]?["distance"] == null
                      ? "Jarak: -"
                      : "Jarak: ${data["keluar"]!["distance"].toString().split(".").first} Meter",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  data["keluar"]?["status"] == null
                      ? "Status: -"
                      : "Status: ${data["keluar"]!["status"]}",
                  style: TextStyle(color: Colors.green[900]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
