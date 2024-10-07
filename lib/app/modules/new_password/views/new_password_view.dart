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
          'KATA SNADI BARU',
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
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
              onPressed: () {
                controller.newPassword();
              },
              child: Text(
                "GANTI KATA SANDI",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
