import 'dart:async';
import 'package:app_veterinario/model/consulta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String consultaTable = "Consultas";
const String idCol = "_id";
const String nomeDonoCol = "nomeDono";
const String nomePetCol = "nomePet";
const String emailCol = "email";
const String telefoneCol = "telefone";
const String tempoProxConsultaCol = "tempoProxConsulta";
const String valorConsultaCol = "valorConsulta";
const String descricaoCol = "descricao";

class ConsultaHelper {
  static final ConsultaHelper _instance = ConsultaHelper.internal();
  factory ConsultaHelper() => _instance;
  ConsultaHelper.internal();
  Database? _db = null;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "baseconsultas.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $consultaTable ($idCol TEXT PRIMARY KEY , $nomeDonoCol TEXT, $nomePetCol TEXT, $emailCol TEXT, $telefoneCol TEXT, $tempoProxConsultaCol TEXT, $valorConsultaCol TEXT, $descricaoCol TEXT)");
    });
  }

  Future<Consulta> inserir(Consulta contact) async {
    Database dbContact = await db;
    int? idNew = Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT MAX($idCol) FROM $consultaTable"));
    if (idNew == null) {
      idNew = 1;
    } else {
      idNew = idNew + 1;
    }
    contact.id = idNew.toString();
    await dbContact.insert(consultaTable, contact.toMap());
    return contact;
  }

  Future<Consulta?> getObjeto(int idFind) async {
    Database dbContact = await db;
    List<Map<String, dynamic>> maps = await dbContact.query(consultaTable,
        columns: [
          idCol,
          nomeDonoCol,
          nomePetCol,
          emailCol,
          telefoneCol,
          tempoProxConsultaCol,
          valorConsultaCol,
          descricaoCol
        ],
        where: "$idCol = ?",
        whereArgs: [idFind]);
    if (maps.isNotEmpty) {
      return Consulta.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(String idDel) async {
    Database dbContact = await db;
    return await dbContact
        .delete(consultaTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Consulta contact) async {
    Database dbContact = await db;
    return await dbContact.update(consultaTable, contact.toMap(),
        where: "$idCol = ?", whereArgs: [contact.id]);
  }

  Future<List<Consulta>> obterTodos() async {
    Database dbContact = await initDb();
    List listMap = await dbContact.rawQuery("SELECT * FROM $consultaTable");
    List<Consulta> listContact = List.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listContact.add(Consulta.fromMap(m));
    }
    return listContact;
  }

  Future<int?> getQuantidade() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $consultaTable"));
  }

  Future<int?> getMaiorId() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT MAX(*) FROM $consultaTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
