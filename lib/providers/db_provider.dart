import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_scanner/models/scan_model.dart';
export 'package:qr_scanner/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  //instancia de la base de datos
  static final DBProvider db = DBProvider._();
  //constructor privado
  DBProvider._();

//obtener infromacion de la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

//crea la tabla denominada Scans
  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //Genera el link de la base de datos, del archivo de la base de datos
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      /// ''' es un String multi linea
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

//inserta nuevas filas a mi base de datos
//Forma # 1
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor' )
    ''');

    return res;
  }

//Forma # 2
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    //nombre de la tabla, valores a insertar
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);

    // Es el ID del último registro insertado;
    return res;
  }

//obtener registros por medio del id
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    //obtiene todos los valores de la base de datos
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

//obtener todos los registros de la base de datos scans
  Future<List<ScanModel>> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

//obtener todos los rgeistros segun su tipo
//y si no hay nada regresa lista vacia
  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'    
    ''');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }
//actauizar la base de datos
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }
//borrar registros de la base de datos
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }
//borrar todo los regsitros de la tabal scans
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans    
    ''');
    return res;
  }
}
