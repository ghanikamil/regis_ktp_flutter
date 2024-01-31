
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class ListPage extends StatefulWidget {

  // final String name;
  // final String ttl;
  // final String selectedProvince;
  // final String selectedDistrict;
  // final String pekerjaan;
  // final String pendidikan;
  //
  // ListPage({
  //   required this.name,
  //   required this.ttl,
  //   required this.selectedProvince,
  //   required this.selectedDistrict,
  //   required this.pekerjaan,
  //   required this.pendidikan,
  // });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future<Map<String, dynamic>> _loadFormData() async {
    final hiveBox = await Hive.openBox<Map<String, dynamic>>('formDataBox');
    return hiveBox.get('formData', defaultValue: {}) ?? {};
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List penduduk'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Name: ${widget.name}'),
          // Text('Tempat Tanggal Lahir: ${widget.ttl}'),
          // Text('Provinsi: ${widget.selectedProvince}'),
          // Text('Kabupaten: ${widget.selectedDistrict}'),
          // Text('Pekerjaan: ${widget.pekerjaan}'),
          // Text('Pendidikan: ${widget.pendidikan}'),
          Container(
            child: FutureBuilder<Map<String, dynamic>>(
                future: _loadFormData(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Return a loading indicator while waiting for data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final formData =
                        snapshot.data ?? {}; // Access the data from the snapshot
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name: ${formData['name']}'),
                        Text('Tempat Tanggal Lahir: ${formData['ttl']}'),
                        Text('Provinsi: ${formData['selectedProvince']}'),
                        Text('Kabupaten: ${formData['selectedDistrict']}'),
                        Text('Pekerjaan: ${formData['pekerjaan']}'),
                        Text('Pendidikan: ${formData['pendidikan']}'),
                      ],
                    );
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}

