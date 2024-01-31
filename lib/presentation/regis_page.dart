
import 'package:daftar_ktp_new/datasources/json_datasource.dart';
import 'package:daftar_ktp_new/domain/kabupaten_entity.dart';
import 'package:daftar_ktp_new/presentation/list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../domain/provinsi_entity.dart';




class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {

  late Box<Map<String, dynamic>> hiveBox;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();
  TextEditingController _kabupatenController = TextEditingController();
  TextEditingController _provinsiController = TextEditingController();
  TextEditingController _pekerjaanController = TextEditingController();
  TextEditingController _pendidikanController = TextEditingController();

  late List<Provinsi> listProvinsi;
  late List<Kabupaten> listKabupaten;
  Provinsi? selectedProvinsi;
  Kabupaten? selectedKabupaten;

  @override
  void initState() {
    super.initState();

    _openHiveBox();

    listProvinsi=[];
    listKabupaten=[];

    loadProvinsi().then((value) {
      setState(() {
        listProvinsi=value;
      });
    });
  }

  Future<void> _openHiveBox() async {
    hiveBox = await Hive.openBox<Map<String, dynamic>>('formDataBox');
  }

  void _saveFormData() {
    hiveBox.put('formData', {
      'name': _namaController.text,
      'ttl': _ttlController.text,
      'selectedProvince': _provinsiController.text,
      'selectedDistrict': _kabupatenController.text,
      'pekerjaan': _pekerjaanController.text,
      'pendidikan': _pendidikanController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('formulir KTP'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                controller: _namaController,
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'nama harus diisi';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Nama', border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                controller: _ttlController,
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'tempat tanggal lahir harus diisi';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Tempat tanggal lahir',
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: DropdownButtonFormField<Provinsi>(
                value: selectedProvinsi,
                items: listProvinsi.map((provinsi) {
                  return DropdownMenuItem<Provinsi>(
                      value: provinsi,
                      child: Text(provinsi.nama)
                  );
                }).toList(),
                onChanged: (value){
                  setState(() {
                    selectedProvinsi = value;
                    selectedKabupaten = null;
                    loadKabupaten(value!.id).then((value) {
                      setState(() {
                        listKabupaten=value;
                      });
                    });
                  });
                  _provinsiController.text= value!.nama;
                },
                validator: (value){
                  if(value==null){
                    return 'provinsi harus diisi';
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'pilih provinsi',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: DropdownButtonFormField<Kabupaten>(

                value: selectedKabupaten,
                items: listKabupaten.map((district) {
                  return DropdownMenuItem<Kabupaten>(
                    value: district,
                    child: Text(district.nama),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedKabupaten = value;
                  });
                  _kabupatenController.text = value!.nama;
                },
                validator: (value){
                  if(value==null){
                    return 'kabupaten harus diisi';
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'pilih kabupaten',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                controller: _pekerjaanController,
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'pekerjaan harus diisi';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Pekerjaan', border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                controller: _pendidikanController,
                validator: (String? value){
                  if(value!.isEmpty){
                    return 'pendidikan harus diisi';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Pendidikan', border: OutlineInputBorder()),
              ),
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _saveFormData();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      //     ListPage(
                      //       name: _namaController.text,
                      //       ttl: _ttlController.text,
                      //       selectedProvince: _provinsiController.text,
                      //       selectedDistrict: _kabupatenController.text,
                      //       pekerjaan: _pekerjaanController.text,
                      //       pendidikan: _pendidikanController.text,
                      //     )
                      // ));
                      context.go('/list');
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ListPage()));
                    }
                  },
                  child: Text('Submit')
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: (){
                  context.go('/list');
                },
                child: Text('list KTP'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
