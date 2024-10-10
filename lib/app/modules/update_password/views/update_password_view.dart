import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GANTI KATA SANDI',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        leading: SizedBox(),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: controller.passC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: Colors.green[900],
            decoration: InputDecoration(
                labelText: "Kata Sandi Sekarang",
                labelStyle: TextStyle(color: Colors.green[900]),
                icon: Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.green[900],
                ),
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.newPassC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: Colors.green[900],
            decoration: InputDecoration(
                labelText: "Kata Sandi Baru",
                labelStyle: TextStyle(color: Colors.green[900]),
                icon: Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.green[900],
                ),
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.confirmNewPassC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: Colors.green[900],
            decoration: InputDecoration(
                labelText: "Konfirmasi Kata Sandi Baru",
                labelStyle: TextStyle(color: Colors.green[900]),
                icon: Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.green[900],
                ),
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 50),
          Obx(
            () {
              return ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updatePassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900]),
                child: Text(
                  controller.isLoading.isFalse
                      ? "GANTI KATA SANDI"
                      : "TUNGGU YA..",
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
