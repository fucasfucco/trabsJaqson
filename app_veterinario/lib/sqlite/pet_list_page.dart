import 'package:app_veterinario/model/pet.dart';
import 'package:app_veterinario/sqlite/PetHelper.dart';
import 'package:app_veterinario/sqlite/pet_edit_page.dart';
import 'package:app_veterinario/util/dialogos.dart';
import 'package:flutter/material.dart';

class PetsListPage extends StatefulWidget {
  const PetsListPage({super.key, this.title});
  final String? title;

  @override
  State<PetsListPage> createState() => _PetsListPageState();
}

class _PetsListPageState extends State<PetsListPage> {
  final petsDb = PetHelper();
  List<Pet> pets = List.empty();
  Pet? selecionado;

  void _getAllContacts() {
    petsDb.obterTodos().then((list) {
      setState(() {
        pets = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  selecionar(int selecao) {
    selecionado = pets[selecao];
    _showContactPage();
  }

  void _incluir() {
    selecionado = Pet();
    _showContactPage();
  }

  void _showContactPage() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PetsEditPage(
                  selecionado: selecionado,
                )));
    if (result != null) {
      if (result == 'Salvar') {
        if (selecionado!.id == null) {
          petsDb.inserir(selecionado!).then((_) {
            _getAllContacts();
            Dialogos.showAlertDialog(context, 'Dados inseridos com sucesso!');
          });
        } else {
          petsDb.alterar(selecionado!).then((_) {
            _getAllContacts();
            Dialogos.showAlertDialog(context, 'Dados alterados com sucesso!');
          });
        }
      } else if (result == 'Excluir') {
        petsDb.excluir(selecionado!.id!).then((_) {
          _getAllContacts();
          Dialogos.showAlertDialog(context, 'Dados excluídos com sucesso!');
        });
      } else if (result == 'Cancelar') {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("pets"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView.separated(
            padding: const EdgeInsets.all(10.0),
            itemCount: pets.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(children: <Widget>[
                  Text('${pets[index].id}'),
                  const SizedBox(width: 20),
                  Text(pets[index].nome!),
                  const SizedBox(width: 20),
                  Text(pets[index].raca!),
                  const SizedBox(width: 20),
                  Text(pets[index].idade!),
                ]),
                onTap: () => selecionar(index),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incluir,
        tooltip: 'incluir',
        child: const Icon(Icons.add),
      ),
    );
  }
}
