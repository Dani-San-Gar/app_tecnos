import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
class FirebasePage extends StatefulWidget {
  const FirebasePage({super.key});
 
  @override
  State<FirebasePage> createState() => _FirebasePageState();
}
 
class _FirebasePageState extends State<FirebasePage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _firebaseData = [];
 
  @override
  void initState() {
    super.initState();
    _loadData();
  }
 
  Future<void> _loadData() async {
    final QuerySnapshot snapshot = await _firestore.collection('data').get();
    setState(() {
      _firebaseData = snapshot.docs.map((doc) => doc['value'] as String).toList();
    });
  }
 
  Future<void> _addFirebaseData() async {
    if (_controller.text.isNotEmpty) {
      await _firestore.collection('data').add({
        'value': _controller.text,
      });
      _controller.clear();
      _loadData();
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Datos en Firebase'),
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
              onPressed: _addFirebaseData,
              child: const Text('Agregar Dato'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Datos en Firebase:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _firebaseData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_firebaseData[index]),
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