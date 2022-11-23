import 'package:app_veterinario/model/consulta.dart';
import 'package:app_veterinario/sqlite/ConsultaHelper.dart';
import 'package:app_veterinario/sqlite/consultas_edit_page.dart';
import 'package:app_veterinario/util/dialogos.dart';
import 'package:flutter/material.dart';

class ConsultasListPage extends StatefulWidget {
  const ConsultasListPage({super.key, this.title});
  final String? title;

  @override
  State<ConsultasListPage> createState() => _ConsultasListPageState();
}

class _ConsultasListPageState extends State<ConsultasListPage> {
  final consultasDb = ConsultaHelper();
  List<Consulta> consultas = List.empty();
  Consulta? selecionado;

  void _getAllContacts() {
    consultasDb.obterTodos().then((list) {
      setState(() {
        consultas = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  selecionar(int selecao) {
    selecionado = consultas[selecao];
    _showContactPage();
  }

  void _incluir() {
    selecionado = Consulta();
    _showContactPage();
  }

  void _showContactPage() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConsultasEditPage(
                  selecionado: selecionado,
                )));
    if (result != null) {
      if (result == 'Salvar') {
        if (selecionado!.id == null) {
          consultasDb.inserir(selecionado!).then((_) {
            _getAllContacts();
            Dialogos.showAlertDialog(context, 'Dados inseridos com sucesso!');
          });
        } else {
          consultasDb.alterar(selecionado!).then((_) {
            _getAllContacts();
            Dialogos.showAlertDialog(context, 'Dados alterados com sucesso!');
          });
        }
      } else if (result == 'Excluir') {
        consultasDb.excluir(selecionado!.id!).then((_) {
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
        title: const Text("Consultas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView.separated(
            padding: const EdgeInsets.all(10.0),
            itemCount: consultas.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(children: <Widget>[
                  Text('${consultas[index].id}'),
                  const SizedBox(width: 20),
                  Text(consultas[index].nomeDono!),
                  const SizedBox(width: 20),
                  Text(consultas[index].email!),
                  const SizedBox(width: 20),
                  Text(consultas[index].tempoProxConsulta!),
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
