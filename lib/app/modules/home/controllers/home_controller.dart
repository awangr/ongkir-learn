import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import '../../../data/model/courier_model.dart';

class HomeController extends GetxController {
  final hiddenKotaAsal = true.obs;
  final provAsalId = 0.obs;
  final hiddenKotaTujuan = true.obs;
  final provTujuanId = 0.obs;
  final kotaAsalId = 0.obs;
  final kotaTujuanlId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = ''.obs;
  String satuan = 'gram';
  double berat = 0.0;
  late TextEditingController beratC;
  void ubahBerat(String val) {
    berat = double.tryParse(val) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case 'ton':
        berat = berat * 1000000;
        break;
      case 'kwintal':
        berat = berat * 100000;
        break;
      case 'ons':
        berat = berat * 100;
      case 'lbs':
        berat = berat * 2204.62;
      case 'pound':
        berat = berat * 2204.62;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    print('$berat' + 'gram');
    showButton();
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 2204.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;

    print("$berat gram");
    showButton();
  }

  void showButton() {
    if (kotaAsalId != 0 && kotaTujuanlId != 0 && berat > 0 && kurir != '') {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: '$berat');
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }

  void ongkosKirim() async {
    Uri url = Uri.parse('https://api.rajaongkir.com/starter/cost');
    try {
      final response = await http.post(url, body: {
        'origin': '$kotaAsalId',
        'destination': '$kotaTujuanlId',
        'weight': '$berat',
        'courier': '$kurir',
      }, headers: {
        'key': '4cd7712637d772706397b6c436ae3e9e',
        'content-type': 'application/x-www-form-urlencoded'
      });
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      print(data);
    } catch (e) {}
  }

  // void ongkosKirim() async {
  //   Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: {
  //         "origin": "$kotaAsalId",
  //         "destination": "$kotaTujuanlId",
  //         "weight": "$berat",
  //         "courier": "$kurir",
  //       },
  //       headers: {
  //         "key": "4cd7712637d772706397b6c436ae3e9e",
  //         "content-type": "application/x-www-form-urlencoded",
  //       },
  //     );

  //     var data = json.decode(response.body) as Map<String, dynamic>;
  //     var results = data["rajaongkir"]["results"];

  //     // var listAllCourier = Courier.fromJsonList(results);
  //     // var courier = listAllCourier[0];
  //     print(data);
  //     // Get.defaultDialog(
  //     //   title: courier.name!,
  //     //   content: Column(
  //     //     children: courier.costs!
  //     //         .map(
  //     //           (e) => ListTile(
  //     //             title: Text("${e.service}"),
  //     //             subtitle: Text("Rp ${e.cost![0].value}"),
  //     //             trailing: Text(
  //     //               courier.code == "pos"
  //     //                   ? "${e.cost![0].etd}"
  //     //                   : "${e.cost![0].etd} HARI",
  //     //             ),
  //     //           ),
  //     //         )
  //     //         .toList(),
  //     //   ),
  //     // );
  //   } catch (err) {
  //     print(err);
  //     Get.defaultDialog(
  //       title: "Terjadi Kesalahan",
  //       middleText: err.toString(),
  //     );
  //   }
  // }
}
