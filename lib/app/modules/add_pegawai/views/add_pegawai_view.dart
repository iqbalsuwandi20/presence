import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TAMBAH PEGAWAI',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: const SizedBox(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          TextField(
            controller: controller.nipC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.card_membership,
                  color: Colors.green[900],
                ),
                labelText: "NIP",
                labelStyle: TextStyle(color: Colors.green[900]),
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.person_outlined,
                  color: Colors.green[900],
                ),
                labelText: "Nama",
                labelStyle: TextStyle(color: Colors.green[900]),
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.email_outlined,
                  color: Colors.green[900],
                ),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.green[900]),
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.jobC,
            autocorrect: false,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.work_history_outlined,
                  color: Colors.green[900],
                ),
                labelText: "Pekerjaan",
                labelStyle: TextStyle(color: Colors.green[900]),
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 50,
          ),
          Obx(
            () {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900]),
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.addPegawai();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse
                        ? "TAMBAH PEGAWAI"
                        : "TUNGGU YA..",
                    style: TextStyle(color: Colors.white),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
