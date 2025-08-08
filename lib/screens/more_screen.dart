import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/data/shared_pref_data.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/screens/language_screen.dart';
import 'package:mad_2_412/screens/login_screen.dart';
import 'package:mad_2_412/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String? _fullName = "Guest";
  bool _isLogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final User? user = await _auth.currentUser;
    String username = user!.email!.split("@")[0];
    setState(() {
      _fullName = username;
      _isLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("more".tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('language'.tr),
                  subtitle: Text(
                    Get.deviceLocale?.languageCode == "en_US"
                        ? "englishLanguage".tr
                        : "khmerLanguage".tr,
                  ),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () {
                    Get.to(LanguageScreen());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text("Theme"),
                  subtitle: Text(Get.isDarkMode ? "Dark" : "Light"),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () {
                    Get.to(ThemeScreen());
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Profile"),
                  subtitle: Text("$_fullName"),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () {
                    _validateLogin();
                  },
                ),
                Divider(),
              ],
            ),
          ),
          _isLogin ? _logoutButton : Container(),
        ],
      ),
    );
  }

  Widget get _logoutButton {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: SizedBox(
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            _logout();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logout", style: TextStyle(color: Colors.white)),
              SizedBox(width: 4),
              Icon(Icons.logout, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Get.off(LoginScreen());
  }

  Future<void> _validateLogin() async {
    if (!_isLogin) {
      Get.off(LoginScreen());
    } else {
      // To Account Screen
    }
  }
}
