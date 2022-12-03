import 'dart:async';
import 'package:app_veterinario/model/pet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String petTable = "Pets";
const String idCol = "_id";
const String nome = "nome";
const String raca = "raca";
const String idade = "idade";

class PetHelper {
  static final PetHelper _instance = PetHelper.internal();
  factory PetHelper() => _instance;
  PetHelper.internal();
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
    final path = join(databasesPath, "basepets.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $petTable ($idCol TEXT PRIMARY KEY , $nome TEXT, $raca TEXT, $idade TEXT)");
    });
  }

  Future<Pet> inserir(Pet contact) async {
    Database dbContact = await db;
    int? idNew = Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT MAX($idCol) FROM $petTable"));
    if (idNew == null) {
      idNew = 1;
    } else {
      idNew = idNew + 1;
    }
    contact.id = idNew.toString();
    await dbContact.insert(petTable, contact.toMap());
    return contact;
  }

  Future<Pet?> getObjeto(int idFind) async {
    Database dbContact = await db;
    List<Map<String, dynamic>> maps = await dbContact.query(petTable,
        columns: [
          idCol,
          nome,
          raca,
          idade,
        ],
        where: "$idCol = ?",
        whereArgs: [idFind]);
    if (maps.isNotEmpty) {
      return Pet.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(String idDel) async {
    Database dbContact = await db;
    return await dbContact
        .delete(petTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Pet contact) async {
    Database dbContact = await db;
    return await dbContact.update(petTable, contact.toMap(),
        where: "$idCol = ?", whereArgs: [contact.id]);
  }

  Future<List<Pet>> obterTodos() async {
    Database dbContact = await initDb();
    List listMap = await dbContact.rawQuery("SELECT * FROM $petTable");
    List<Pet> listContact = List.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listContact.add(Pet.fromMap(m));
    }
    return listContact;
  }

  Future<int?> getQuantidade() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $petTable"));
  }

  Future<int?> getMaiorId() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT MAX(*) FROM $petTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
