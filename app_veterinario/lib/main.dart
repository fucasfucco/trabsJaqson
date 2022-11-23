import 'package:app_veterinario/pages/contador.dart';
import 'package:app_veterinario/pages/home.dart';
import 'package:app_veterinario/pages/sobre.dart';
import 'package:app_veterinario/sqlite/consultas_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/contador': (context) => const ContadorPage(title: "Contador"),
        '/sobre': (context) => const SobrePage(),
        '/consultasListPage': (context) =>
            const ConsultasListPage(title: "Consultas SQLite"),
      },
    );
  }
}
