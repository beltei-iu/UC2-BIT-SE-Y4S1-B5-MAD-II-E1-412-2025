import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/data/shared_pref_data.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/screens/login_screen.dart';
import 'package:mad_2_412/screens/phone_screen.dart';
import 'package:mad_2_412/widgets/logo_widget.dart';
import 'package:mad_2_412/widgets/social_login_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isObscureText = true;
  bool _isEmailValid = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Create FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body);
  }

  Widget get _body {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogoWidget(),
            SizedBox(height: 20),
            _fullNameTextFormField,
            const SizedBox(height: 20),
            _emailTextFormField,
            const SizedBox(height: 20),
            _passwordTextFormField,
            const SizedBox(height: 20),
            _registerButton,
            const SizedBox(height: 20),
            SocialLoginWidget(),
            _navigateToLoginButton,
          ],
        ),
      ),
    );
  }

  Widget get _fullNameTextFormField {
    return TextFormField(
      controller: _fullNameController,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter your full name' : null,
      decoration: InputDecoration(
        prefix: Icon(Icons.account_circle, color: Colors.grey),

        labelText: 'Full Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget get _emailTextFormField {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) => {
        if (value.contains("@"))
          {
            setState(() {
              _isEmailValid = true;
            }),
          }
        else
          {
            setState(() {
              _isEmailValid = false;
            }),
          },
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter your email' : null,
      decoration: InputDecoration(
        prefix: Icon(Icons.email, color: Colors.grey),
        suffixIcon: _isEmailValid
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.check_circle, color: Colors.grey),
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget get _passwordTextFormField {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscureText,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: _isObscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscureText = !_isObscureText;
                  });
                },
                icon: const Icon(Icons.visibility_off, color: Colors.grey),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    _isObscureText = !_isObscureText;
                  });
                },
                icon: const Icon(Icons.visibility, color: Colors.grey),
              ),
      ),
    );
  }

  Widget get _registerButton {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            String fullName = _fullNameController.text;
            String email = _emailController.text;
            String password = _passwordController.text;
            print("Full Name : $fullName");
            print("Email : $email");
            print("Password : $password");
            // Firebase Auth
            _onRegister(email, password);
          }
        },
        child: Text("Register"),
      ),
    );
  }

  Widget get _navigateToLoginButton {
    return TextButton(
      onPressed: () {
        // Navigate to the registration screen
        AppRoute.key.currentState?.pushNamed(AppRoute.login);
      },
      child: const Text(
        "Already an exist Login",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Future<void> _onRegister(String email, String password) async {
    try {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
            print("User : ${user.additionalUserInfo}");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Register successful.')),
            );
            // Navigation
            Get.to(LoginScreen());
          })
          .catchError((error) {
            print("Error : $error");
          });
    } catch (e) {
      print("Error : $e");
    }
  }
}
