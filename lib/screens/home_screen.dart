import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, Guest'),
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      body: Column(children: [_searchWidget]),
    );
  }

  Widget get _searchWidget {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
        onChanged: (value) {
          print("Searching for: $value");
        },
      ),
    );
  }
}
