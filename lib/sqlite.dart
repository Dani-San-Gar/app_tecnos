import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
 
class SQLitePage extends StatefulWidget {
  const SQLitePage({super.key});
 
  @override
  State<SQLitePage> createState() => _SQLitePageState();
}
 
class _SQLitePageState extends State<SQLitePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _sqliteData = [];
  late Database _database;
 
  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }
 
  Future<void> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'data.db');
 
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE Data (id INTEGER PRIMARY KEY, value TEXT)',
      );
    });
 
    _loadData();
  }
 
  Future<void> _loadData() async {
    final List<Map<String, dynamic>> maps = await _database.query('Data');
    setState(() {
      _sqliteData = List.generate(maps.length, (i) {
        return maps[i]['value'] as String;
      });
    });
  }
 
  Future<void> _addSQLiteData() async {
    if (_controller.text.isNotEmpty) {
      await _database.insert(
        'Data',
        {'value': _controller.text},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      _controller.clear();
      _loadData();
    }
  }
 
  @override
  void dispose() {
    _database.close();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Datos SQLite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese Dato',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addSQLiteData,
              child: const Text('Agregar Dato'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Datos ingresados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _sqliteData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_sqliteData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}