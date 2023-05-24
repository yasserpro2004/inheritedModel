import 'package:flutter/material.dart';
import 'dart:math' show Random;

void main() {
  runApp(
    MaterialApp(
      title: 'demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}

final colors = [
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.brown,
  Colors.amber,
  Colors.deepPurple,
];

extension RandomElement<E> on Iterable<E> {
  E getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}
