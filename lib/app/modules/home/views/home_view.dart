import 'package:cek_ongkir/app/modules/home/views/widgets/kota.dart';
import 'package:cek_ongkir/app/modules/home/views/widgets/provinsi.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/berat.dart';

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
                  : Kota(
                      provId: controller.provAsalId.value,
                      tipe: 'asal',
                    )),
              Provinsi(tipe: 'tujuan'),
              Obx(() => controller.hiddenKotaTujuan.isTrue
                  ? SizedBox()
                  : Kota(
                      provId: controller.provTujuanId.value, tipe: 'tujuan')),
              BeratBarang(),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: DropdownSearch<Map<String, dynamic>?>(
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          InputDecoration(border: OutlineInputBorder())),
                  popupProps: PopupProps.menu(),
                  items: [
                    {
                      "code": "jne",
                      "name": "Jalur Nugraha Ekakurir (JNE)",
                    },
                    {
                      "code": "tiki",
                      "name": "Titipan Kilat (TIKI)",
                    },
                    {
                      "code": "pos",
                      "name": "Perusahaan Opsional Surat (POS)",
                    },
                  ],
                  //  itemAsString: (item) => "$item['name']",

                  onChanged: (value) {
                    if (value != null) {
                      controller.kurir.value = value["name"];
                      controller.showButton();
                    } else {
                      controller.hiddenButton.value = true;
                      controller.kurir.value = "";
                    }
                  },
                ),
              ),
              Obx(() => controller.hiddenButton.isFalse
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () => controller.ongkosKirim(),
                      child: Text('CEK ONGKIR')))
            ],
          ),
        ));
  }
}
