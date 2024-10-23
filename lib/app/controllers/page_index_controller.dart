import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    // ignore: avoid_print
    print("klik index = $i");

    switch (i) {
      case 1:
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse["error"] != true) {
          Position position = dataResponse["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          String address =
              "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";

          await updatePosition(
            position,
            address,
          );

          double distance = Geolocator.distanceBetween(
            -6.2182594,
            106.6713904,
            position.latitude,
            position.longitude,
          );

          await presence(position, address, distance);

          // ignore: avoid_print
          print("${position.latitude}, ${position.longitude}");
        } else {
          Get.snackbar("TERJADI KESALAHAN", dataResponse["message"]);
        }
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        "message": "Tidak dapat mengambil GPS.",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          "message": "Izinkan menggunakan GPS di tolak.",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {
        "message": "Pengaturan di hp anda tidak ada akses untuk GPS.",
        "error": true,
      };
    }

    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "POSISI ANDA DI TEMUKAN",
      "error": false,
    };
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;

    await firestore.collection("pegawai").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address,
    });
  }

  Future<void> presence(
      Position position, String address, double distance) async {
    String uid = auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> collectionPresence =
        // ignore: await_only_futures
        await firestore.collection("pegawai").doc(uid).collection("presence");

    QuerySnapshot<Map<String, dynamic>> snapshotPresence =
        await collectionPresence.get();

    DateTime now = DateTime.now();
    String todayDocID = DateFormat.yMd().format(now).replaceAll("/", "-");

    // ignore: avoid_print
    print(todayDocID);

    String status = "Luar Area Kantor";

    if (distance <= 100) {
      status = "Dalam Area Kantor";
    }

    if (snapshotPresence.docs.isEmpty) {
      await Get.defaultDialog(
        title: "Validasi Absensi",
        middleText: "Apakah anda yakin untuk absensi masuk?",
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
              child: Text(
                "BATAL",
                style: TextStyle(color: Colors.white),
              )),
          Obx(
            () {
              return ElevatedButton(
                  onPressed: () async {
                    if (isLoading.isFalse) {
                      await collectionPresence.doc(todayDocID).set({
                        "date": now.toIso8601String(),
                        "masuk": {
                          "clock": now.toIso8601String(),
                          "lat": position.latitude,
                          "long": position.longitude,
                          "address": address,
                          "status": status,
                          "distance": distance,
                        },
                      });
                    }
                    Get.back();
                    Get.snackbar("BERHASIL",
                        "Anda berhasil absensi masuk, anda berada di $address");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900]),
                  child: Text(
                    isLoading.isFalse ? "YAKIN" : "TUNGGU YA..",
                    style: TextStyle(color: Colors.white),
                  ));
            },
          ),
        ],
      );
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await collectionPresence.doc(todayDocID).get();
      if (todayDoc.exists == true) {
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        if (dataPresenceToday?["keluar"] != null) {
          Get.snackbar("INFORMASI",
              "Anda telah absen masuk dan keluar. Tidak dapat mengubah data kembali.");
        } else {
          await Get.defaultDialog(
            title: "Validasi Absensi",
            middleText: "Apakah anda yakin untuk absensi keluar?",
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900]),
                  child: Text(
                    "BATAL",
                    style: TextStyle(color: Colors.white),
                  )),
              Obx(
                () {
                  return ElevatedButton(
                      onPressed: () async {
                        if (isLoading.isFalse) {
                          await collectionPresence.doc(todayDocID).update({
                            "keluar": {
                              "clock": now.toIso8601String(),
                              "lat": position.latitude,
                              "long": position.longitude,
                              "address": address,
                              "status": status,
                              "distance": distance,
                            },
                          });
                        }
                        Get.back();
                        Get.snackbar("BERHASIL",
                            "Anda berhasil abnsensi keluar, anda berada di $address");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900]),
                      child: Text(
                        isLoading.isFalse ? "YAKIN" : "TUNGGU YA..",
                        style: TextStyle(color: Colors.white),
                      ));
                },
              ),
            ],
          );
        }
      } else {
        await Get.defaultDialog(
          title: "Validasi Absensi",
          middleText: "Apakah anda yakin untuk absensi masuk?",
          actions: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900]),
                child: Text(
                  "BATAL",
                  style: TextStyle(color: Colors.white),
                )),
            Obx(
              () {
                return ElevatedButton(
                    onPressed: () async {
                      if (isLoading.isFalse) {
                        await collectionPresence.doc(todayDocID).set({
                          "date": now.toIso8601String(),
                          "masuk": {
                            "clock": now.toIso8601String(),
                            "lat": position.latitude,
                            "long": position.longitude,
                            "address": address,
                            "status": status,
                            "distance": distance,
                          },
                        });
                      }
                      Get.back();
                      Get.snackbar("BERHASIL",
                          "Anda berhasil absensi masuk, anda berada di $address");
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[900]),
                    child: Text(
                      isLoading.isFalse ? "YAKIN" : "TUNGGU YA..",
                      style: TextStyle(color: Colors.white),
                    ));
              },
            ),
          ],
        );
      }
    }
  }
}
