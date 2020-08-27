import 'dart:async';

import 'package:moodleapp/database/db_helper.dart';
import 'package:moodleapp/entitys/dados.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class DadosDAO {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> save(Dados dados) async {
    var dbClient = await db;
    var id = await dbClient.insert("dados", dados.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Save id: $id');
    return id;
  }

  Future<int> update(Dados dado) async {
    var dbClient = await db;
    var id = await dbClient
        .update("dados", dado.toMap(), where: "id = ?", whereArgs: [dado.id]);
    print('Update id: $id');
    return id;
  }

  Future<List<Dados>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from dados');

    final carros = list.map<Dados>((json) => Dados.fromJson(json)).toList();

    return carros;
  }

  Future<List<Dados>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from dados where tipo =? ', [tipo]);

    final carros = list.map<Dados>((json) => Dados.fromJson(json)).toList();

    return carros;
  }

  Future<Dados> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from dados where id = ?', [id]);

    if (list.length > 0) {
      return new Dados.fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(Dados dados) async {
    Dados c = await findById(dados.id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from dados');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from dados where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from dados');
  }
}
