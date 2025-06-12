import 'package:flutter/material.dart';
import 'package:mad_2_412/data/shared_pref_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName;

  @override
  void initState() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    String? username = await sharedPref.getString(SharedPrefData.FULL_NAME);
    String? email = await sharedPref.getString(SharedPrefData.EMAIL);
    print("username : $username");
    print("email : $email");
    String subEmail = email != null ? email.split("@")[0] : "Guest";
    setState(() {
      fullName = username ?? subEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${fullName.toString()}'),
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
