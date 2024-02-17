import 'dart:convert';

import 'package:cek_ongkir/app/data/model/province_model.dart';
import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({Key? key, required this.tipe}) : super(key: key);
  final String tipe;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Provinces>(
        dropdownBuilder: (context, item) {
          return Container(
            child: Text('${item?.province}'),
          );
        },
        asyncItems: (String filter) async {
          Uri url = Uri.parse('https://api.rajaongkir.com/starter/province');
          try {
            final res = await http
                .get(url, headers: {'key': '4cd7712637d772706397b6c436ae3e9e'});
            var data = jsonDecode(res.body) as Map<String, dynamic>;
            var statusCode = data['rajaongkir']['status']['code'];
            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }
            var listAllProvince =
                data['rajaongkir']['results'] as List<dynamic>;
            var models = Provinces.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            print('Error + $e');
            return List<Provinces>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = false;
              controller.provAsalId.value = int.parse(value.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanId.value = int.parse(value.provinceId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
          print(value);
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                    tipe == 'asal' ? 'Provinsi Asal' : 'Provinsi Tujuan'))),
/*        clearButtonProps: ClearButtonProps(
            icon: IconButton(onPressed: () {}, icon: Icon(Icons.cancel))),*/
        popupProps: PopupProps.menu(showSearchBox: true),
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
