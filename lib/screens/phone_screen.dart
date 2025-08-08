import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {

  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {


  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Number"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          ElevatedButton(onPressed: (){
            String phoneNumber = _phoneController.text;
            _onVerifyPhone(phoneNumber);
          }, child: Text("Submit"))
        ],
      )
    );
  }

  Future<void> _onVerifyPhone(String phoneNumber) async{
    try{
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            print("Credential : $credential");
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e){
            print("Error verificationFailed : $e");
          },
          codeSent: (String verificationId, int? resendToken){
            print("Verification Id : $verificationId");
          },
          codeAutoRetrievalTimeout: (String verificationId){
            print("Verification Id : $verificationId");
          }
      );
    }catch(e){
      print("Error catch: $e");
    }
  }
}
