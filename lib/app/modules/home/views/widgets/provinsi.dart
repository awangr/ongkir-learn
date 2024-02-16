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
        clearButtonProps: ClearButtonProps(
            icon: IconButton(onPressed: () {}, icon: Icon(Icons.cancel))),
        popupProps: PopupProps.menu(),
      ),
    );
  }
}
