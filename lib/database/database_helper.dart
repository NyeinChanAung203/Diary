import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _db;
  static const String tableName = 'user';

  DatabaseHelper() {
    _createDatabase();
  }

  Future<Database> _createDatabase() async {
    var dataPath = await getDatabasesPath(); // database folder path
    String path = join(dataPath, 'databasename.db');
    _db = await openDatabase(path);

    //create table
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(username TEXT,password TEXT,question TEXT,pic BLOB)
      ''');

    return _db;
  }

  Future<int> insertStudent(Map<String, dynamic> student) async {
    _db = await _createDatabase();
    return await _db.insert(tableName, student);
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    _db = await _createDatabase();
    return await _db
        .query(tableName, columns: ['id', 'name', 'address', 'email', 'phone']);
  }

  Future<int> updateStudent(Map<String, dynamic> student, int id) async {
    _db = await _createDatabase();
    return await _db.update(tableName, student, where: "id=?", whereArgs: [id]);
  }

  Future<int> deleteStudent(int id) async {
    _db = await _createDatabase();
    return await _db.delete(tableName, where: "id=?", whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    _db = await _createDatabase();
    return await _db.rawDelete("DELETE FROM $tableName");
  }
}
