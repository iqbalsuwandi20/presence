import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KATA SANDI BARU',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: controller.newPassC,
            autocorrect: false,
            obscureText: true,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                icon: Icon(Icons.password_outlined, color: Colors.green[900]),
                labelText: "Kata Sandi Baru",
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
                      await controller.newPassword();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse
                        ? "GANTI KATA SANDI"
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
