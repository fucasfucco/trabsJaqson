import 'package:flutter/material.dart';
import '../model/pet.dart';

class PetsEditPage extends StatefulWidget {
  const PetsEditPage({super.key, this.selecionado});

  final Pet? selecionado;

  @override
  State<PetsEditPage> createState() => _PetsEditPageState();
}

class _PetsEditPageState extends State<PetsEditPage> {
  final _nomeCon = TextEditingController();
  final _racaCon = TextEditingController();
  final _idadeCon = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nomeCon.text = widget.selecionado!.nome!;
    _racaCon.text = widget.selecionado!.raca!;
    _idadeCon.text = widget.selecionado!.idade!;
  }

  void salvar() {
    widget.selecionado!.nome = _nomeCon.text;
    widget.selecionado!.raca = _racaCon.text;
    widget.selecionado!.idade = _idadeCon.text;
    Navigator.pop(context, 'Salvar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nomeCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome do Pet',
              ),
            ),
            TextFormField(
              controller: _racaCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Raça',
              ),
            ),
            TextFormField(
              controller: _idadeCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Idade',
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Salvar'),
                    onPressed: () {
                      salvar();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Excluir'),
                    onPressed: () {
                      Navigator.pop(context, 'Excluir');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context, 'Cancelar');
                    },
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
