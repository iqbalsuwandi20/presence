import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_presence_controller.dart';

class DetailPresenceView extends GetView<DetailPresenceController> {
  const DetailPresenceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPresenceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPresenceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
