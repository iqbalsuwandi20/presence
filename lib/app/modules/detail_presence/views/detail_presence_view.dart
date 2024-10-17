import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  const DetailPresenceView({super.key});
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
                        .format(DateTime.now())
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
                  "Jam: ${DateFormat.jms().format(DateTime.now())}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  "Posisi:",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  "Status:",
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
                  "Jam: ${DateFormat.jms().format(DateTime.now())}",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  "Posisi:",
                  style: TextStyle(color: Colors.green[900]),
                ),
                Text(
                  "Status:",
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
