// import 'package:daftar_ktp_new/presentation/regis_page.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: DaftarPage(),
//     );
//   }
// }

import 'package:daftar_ktp_new/presentation/list_page.dart';
import 'package:daftar_ktp_new/presentation/regis_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  runApp(const MyApp());
}

final _router = GoRouter(initialLocation: '/form', routes: [
  GoRoute(
    name: 'form',
    path: '/form',
    builder: (context, state) => DaftarPage(),
  ),
  GoRoute(
    name: 'list',
    path: '/list',
    builder: (context, state) => ListPage(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
      // home: DaftarPage(),
    );
  }
}

