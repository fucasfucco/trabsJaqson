import 'package:flutter/material.dart';
import '../model/consulta.dart';

class ConsultasEditPage extends StatefulWidget {
  const ConsultasEditPage({super.key, this.selecionado});

  final Consulta? selecionado;

  @override
  State<ConsultasEditPage> createState() => _ConsultasEditPageState();
}

class _ConsultasEditPageState extends State<ConsultasEditPage> {
  final _nomeDonoCon = TextEditingController();
  final _nomePetCon = TextEditingController();
  final _emailCon = TextEditingController();
  final _telefoneCon = TextEditingController();
  final _tempoProxConsultaCon = TextEditingController();
  final _valorConsultaCon = TextEditingController();
  final _descricaoCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeDonoCon.text = widget.selecionado!.nomeDono!;
    _nomePetCon.text = widget.selecionado!.nomePet!;
    _emailCon.text = widget.selecionado!.email!;
    _telefoneCon.text = widget.selecionado!.telefone!;
    _tempoProxConsultaCon.text = widget.selecionado!.tempoProxConsulta!;
    _valorConsultaCon.text = widget.selecionado!.valorConsulta!;
    _descricaoCon.text = widget.selecionado!.descricao!;
  }

  void salvar() {
    widget.selecionado!.nomeDono = _nomeDonoCon.text;
    widget.selecionado!.nomePet = _nomePetCon.text;
    widget.selecionado!.email = _emailCon.text;
    widget.selecionado!.telefone = _telefoneCon.text;
    widget.selecionado!.tempoProxConsulta = _tempoProxConsultaCon.text;
    widget.selecionado!.valorConsulta = _valorConsultaCon.text;
    widget.selecionado!.descricao = _descricaoCon.text;
    Navigator.pop(context, 'Salvar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nomeDonoCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome do Dono',
              ),
            ),
            TextFormField(
              controller: _nomePetCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome do Pet',
              ),
            ),
            TextFormField(
              controller: _emailCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _telefoneCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telefone',
              ),
            ),
            TextFormField(
              controller: _tempoProxConsultaCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tempo para próxima consulta',
              ),
            ),
            TextFormField(
              controller: _valorConsultaCon,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor Consulta',
              ),
            ),
            TextFormField(
              controller: _descricaoCon,
              keyboardType: TextInputType.text,
              maxLength: 50,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição do atendimento',
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
