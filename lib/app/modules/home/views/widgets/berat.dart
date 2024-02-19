import 'package:cek_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final controller = Get.put(HomeController());

class BeratBarang extends StatefulWidget {
  const BeratBarang({super.key});

  @override
  State<BeratBarang> createState() => _BeratBarangState();
}

class _BeratBarangState extends State<BeratBarang> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autocorrect: false,
            controller: controller.beratC,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                labelText: 'Berat Barang',
                hintText: 'Berat Barang',
                border: OutlineInputBorder()),
            onChanged: (value) => controller.ubahBerat(value),
          )),
          SizedBox(width: 10),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Satuan')),
              items: [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              popupProps: PopupProps.bottomSheet(
                  bottomSheetProps: BottomSheetProps(elevation: 10),
                  title: SizedBox(height: 10),
                  scrollbarProps: ScrollbarProps(),
                  showSearchBox: true,
                  constraints: BoxConstraints(maxHeight: 400)),
              selectedItem: 'Satuan',
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          ),
        ],
      ),
    );
  }
}
