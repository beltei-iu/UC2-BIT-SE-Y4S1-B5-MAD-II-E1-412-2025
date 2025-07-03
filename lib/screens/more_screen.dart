import 'package:flutter/material.dart';
import 'package:mad_2_412/data/shared_pref_data.dart';
import 'package:mad_2_412/route/app_route.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Theme"),
            trailing: Icon(Icons.navigate_next),
          ),
          Divider(),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       SharedPrefData.logout();
          //       AppRoute.key.currentState!.pushReplacementNamed(AppRoute.splash);
          //     },
          //     child: Text("Logout"),
          //   ),
          // )
        ],
      ),
    );
  }
}
