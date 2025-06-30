// lib/data/datasource/local_datasource_impl.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:backbaseassignment/domain/entities/book_detail.dart';
import 'local_datasource.dart';

class LocalDataSourceImpl implements LocalDataSource {
  static const String _tableName = 'saved_books';
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'book_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName('
          'key TEXT PRIMARY KEY, '
          'title TEXT NOT NULL, '
          'authors TEXT, '
          'description TEXT, '
          'coverUrl TEXT'
          ')',
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> saveBook(BookDetail book) async {
    final db = await database;
    await db.insert(
      _tableName,
      _bookDetailToMap(book),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<bool> isBookSaved(String key) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'key = ?',
      whereArgs: [key],
    );
    return result.isNotEmpty;
  }

  @override
  Future<List<BookDetail>> getSavedBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => _mapToBookDetail(maps[i]));
  }

  // Helper methods for conversion
  Map<String, dynamic> _bookDetailToMap(BookDetail book) {
    return {
      'key': book.key,
      'title': book.title,
      'authors': book.authors.join(','), // Convert list to comma-separated string
      'description': book.description,
      'coverUrl': book.coverUrl,
    };
  }

  BookDetail _mapToBookDetail(Map<String, dynamic> map) {
    return BookDetail(
      key: map['key'],
      title: map['title'],
      authors: (map['authors'] as String).split(','), // Convert back to list
      description: map['description'],
      coverUrl: map['coverUrl'],
    );
  }
}