import 'dart:convert';

import 'package:cek_ongkir/app/data/model/city_model.dart';
import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);
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
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
              'https://api.rajaongkir.com/starter/city?province=$provId');
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
            var models = City.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            print('Error + $e');
            return List<City>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            controller.hiddenKotaAsal.value = false;
            controller.provAsalId.value = int.parse(value.provId!);
          } else {
            controller.hiddenKotaAsal.value = true;
            controller.provAsalId.value = 0;
          }
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(tipe == 'asal' ? 'Kota Asal' : 'Kota Tujuan'))),
/*        clearButtonProps: ClearButtonProps(
            icon: IconButton(onPressed: () {}, icon: Icon(Icons.cancel))),*/
        popupProps: PopupProps.menu(showSearchBox: true),
        itemAsString: (item) => item.cityName!,
      ),
    );
  }
}
