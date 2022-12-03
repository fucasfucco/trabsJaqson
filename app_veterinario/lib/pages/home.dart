import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabalho Desenvolvimento Mobile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'App Aula',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/sobre');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_pin_outlined),
              title: const Text('Consultas SQLite'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/consultasListPage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_pin_outlined),
              title: const Text('Pets SQLite'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/petsListPage');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Bem vindo'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/sobre');
              },
              child: const Text('Sobre'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/consultasListPage');
              },
              child: const Text('Consultas SQLite'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/petsListPage');
              },
              child: const Text('Pets SQLite'),
            ),
          ],
        ),
      ),
    );
  }
}
