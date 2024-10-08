import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MASUK',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                icon: Icon(Icons.email_outlined, color: Colors.green[900]),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.green[900]),
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.passC,
            autocorrect: false,
            obscureText: true,
            cursorColor: Colors.green[900],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                icon: Icon(Icons.password_outlined, color: Colors.green[900]),
                labelText: "Kata Sandi",
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
                      await controller.login();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse ? "MASUK" : "TUNGGU YA..",
                    style: TextStyle(color: Colors.white),
                  ));
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Lupa Kata Sandi?",
                style: TextStyle(
                    color: Colors.green[900], fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
