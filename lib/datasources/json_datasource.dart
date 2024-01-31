import 'dart:convert';

import 'package:daftar_ktp_new/domain/kabupaten_entity.dart';
import 'package:daftar_ktp_new/domain/provinsi_entity.dart';
import 'package:flutter/services.dart';



Future<List<Provinsi>> loadProvinsi() async {
  final String data = await rootBundle.loadString('assets/provinces.json');
  final List<dynamic> jsonList = json.decode(data);
  return jsonList.map((json) => Provinsi(id: json['id'], nama: json['name'])).toList();
}

Future<List<Kabupaten>> loadKabupaten(String idProvinsi) async {
  final String data = await rootBundle.loadString('assets/regencies.json');
  final List<dynamic> jsonList = json.decode(data);
  return jsonList
      .where((json) => json['province_id'] == idProvinsi)
      .map((json) => Kabupaten(id: json['id'], idProvinsi: json['province_id'], nama: json['name']))
      .toList();
}