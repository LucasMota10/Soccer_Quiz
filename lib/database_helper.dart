import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'soccer_quiz.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabela de usuários
    await db.execute('''
      CREATE TABLE users (
        id              INTEGER PRIMARY KEY AUTOINCREMENT,
        email           TEXT NOT NULL UNIQUE,
        password        TEXT NOT NULL,
        cpf             TEXT NOT NULL UNIQUE,
        nome            TEXT NOT NULL,
        data_nascimento TEXT NOT NULL,
        tipo_usuario    TEXT NOT NULL,
        created_at      TEXT NOT NULL,
        updated_at      TEXT NOT NULL
      );
    ''');

    // Tabela de reset de senha
    await db.execute('''
      CREATE TABLE password_resets (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        email      TEXT NOT NULL,
        token      TEXT NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');
  }

  // ================== USERS ==================

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<void> updateUserPassword(String email, String newPassword) async {
    final db = await database;
    await db.update(
      'users',
      {
        'password': newPassword,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // ================== PASSWORD RESETS ==================

  Future<void> savePasswordResetToken(String email, String token) async {
    final db = await database;

    // garante que tabela exista (caso banco antigo)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS password_resets (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        email      TEXT NOT NULL,
        token      TEXT NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    // apaga tokens antigos do mesmo email
    await db.delete('password_resets', where: 'email = ?', whereArgs: [email]);

    await db.insert('password_resets', {
      'email': email,
      'token': token,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getPasswordReset(
      String email, String token) async {
    final db = await database;
    final result = await db.query(
      'password_resets',
      where: 'email = ? AND token = ?',
      whereArgs: [email, token],
      limit: 1,
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<void> deletePasswordReset(String email) async {
    final db = await database;
    await db.delete(
      'password_resets',
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
