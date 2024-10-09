import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({super.key});
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GANTI PROFIL',
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
            readOnly: true,
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
            readOnly: true,
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
                      await controller.updateProfile(user["uid"]);
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse
                        ? "GANTI PROFIL"
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
