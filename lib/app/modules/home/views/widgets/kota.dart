import 'dart:convert';

import 'package:cek_ongkir/app/data/model/city_model.dart';
import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Kota extends GetView<HomeController> {
  const Kota({Key? key, required this.provId, required this.tipe})
      : super(key: key);
  final int provId;
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        dropdownBuilder: (context, item) {
          return Container(
            child: Text('${item?.cityName}'),
          );
        },
        itemAsString: (item) => '${item.type} +${item.cityName}',
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                labelText: tipe == 'asal' ? 'Kota Asal' : ' Kota Tujuan')),
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
              'https://api.rajaongkir.com/starter/city?province=$provId');
          try {
            final response = await http
                .get(url, headers: {'key': '4cd7712637d772706397b6c436ae3e9e'});
            var data = jsonDecode(response.body) as Map<String, dynamic>;
            var statusCode = data['rajaongkir']['status']['code'];
            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }
            var listAllCity = data['rajaongkir']['result'] as List<dynamic>;
            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            print('ERRRORRR + $e');
            return List<City>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            if (tipe == 'asal') {
              controller.kotaAsalId.value = int.parse(value.cityId!);
            } else {
              controller.kotaTujuanlId.value = int.parse(value.cityId!);
            }
          } else {
            if (tipe == 'asal') {
              print('Tidak memilih kota/kabupaten asal apapun');
              controller.kotaAsalId.value = 0;
            } else {
              print('Tidak memlih Kota/Kabupaten tujuan apapun');
              controller.kotaTujuanlId.value = 0;
            }
          }
        },
      ),
    );
  }
}
