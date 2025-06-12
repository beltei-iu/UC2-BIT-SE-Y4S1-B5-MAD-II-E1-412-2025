import 'package:flutter/material.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const CircularProgressIndicator(),
              // const SizedBox(height: 20),
              // Text('Loading...'),
              LogoWidget(),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    AppRoute.key.currentState?.pushReplacementNamed(
                      AppRoute.login,
                    );
                  },
                  child: Text(
                    "Login An Account",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    AppRoute.key.currentState?.pushReplacementNamed(
                      AppRoute.home,
                    );
                  },
                  child: Text(
                    "Logon As Guest",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
