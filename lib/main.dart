import 'package:flutter/material.dart';
import 'json.dart';
import 'sqlite.dart';
import 'firebase.dart';
import 'google_maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 47, 190, 159),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Aplicación Múltiples Tecnologías'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/fondo_flutter.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // Fondo semitransparente
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRow(
                  context,
                  [
                    _buildButton(
                      context,
                      icon: Icons.code,
                      text: 'JSON',
                      page: const JsonPage(),
                    ),
                    _buildButton(
                      context,
                      icon: Icons.storage,
                      text: 'SQLite',
                      page: const SQLitePage(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildRow(
                  context,
                  [
                    _buildButton(
                      context,
                      icon: Icons.cloud,
                      text: 'Firebase',
                      page: const FirebasePage(),
                    ),
                    _buildButton(
                      context,
                      icon: Icons.map,
                      text: 'Google Maps',
                      page: OpenStreetMapPage(), // ✅ Corregido
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<Widget> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required String text, required Widget page}) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}