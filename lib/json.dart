import 'package:flutter/material.dart';
import 'dart:convert';

class JsonPage extends StatefulWidget {
  const JsonPage({super.key});

  @override
  State<JsonPage> createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _jsonData = [];

  void _addJsonData() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _jsonData.add(jsonEncode({'value': _controller.text}));
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Datos'),
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
              onPressed: _addJsonData,
              child: const Text('Agregar Dato'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Datos ingresados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _jsonData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = jsonDecode(_jsonData[index]);
                  return ListTile(
                    title: Text(data['value']),
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