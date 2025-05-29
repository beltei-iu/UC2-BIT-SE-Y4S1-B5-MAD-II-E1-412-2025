
import 'package:flutter/material.dart';
import 'package:mad_2_412/route/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _createAccount,
          SizedBox(height: 20,),
          _loginGuest
        ],
      ),),
      ),
    );
  }

  Widget get _createAccount{

      return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red
        ),
        onPressed: (){

      }, child: Text("Create Account", style: TextStyle(color: Colors.white),)),
      );
  }

  Widget get _loginGuest {
    return SizedBox(
              height: 40,
        width: MediaQuery.of(context).size.width,
      child: ElevatedButton(onPressed: (){
         
         
          //Navigator.pushNamed(context, AppRoute.mainScreen);

          AppRoute.key.currentState?.pushNamed(AppRoute.mainScreen);


    }, child: Text("Login as Guest")),
    );
  }
}