import 'package:cek_ongkir/app/modules/home/views/widgets/kota.dart';
import 'package:cek_ongkir/app/modules/home/views/widgets/provinsi.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Provinsi(tipe: 'asal'),
              Obx(() => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : Kota(provId: controller.provAsalId.value, tipe: 'asal')),
              Provinsi(tipe: 'tujuan'),
              Obx(() => controller.hiddenKotaTujuan.isTrue
                  ? SizedBox()
                  : Kota(provId: controller.provTujuanId.value, tipe: 'tujuan'))
            ],
          ),
        ));
  }
}
