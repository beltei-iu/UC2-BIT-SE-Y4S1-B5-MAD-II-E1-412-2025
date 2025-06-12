import 'package:flutter/material.dart';
import 'package:mad_2_412/route/app_route.dart';
import 'package:mad_2_412/widgets/logo_widget.dart';
import 'package:mad_2_412/widgets/social_login_widget.dart';
import 'package:mad_2_412/data/shared_pref_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _formKey = GlobalKey<FormState>();

  bool _isEmailValid = false;
  bool _isObscureText = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            _emailTextFormField,
            const SizedBox(height: 20),
            _passwordTextFormField,
            const SizedBox(height: 20),
            _loginButton,
            const SizedBox(height: 20),
            SocialLoginWidget(),
            _navigateToRegisterButton,
          ],
        ),
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

  Widget get _loginButton {
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
            // Perform login action

              String email = _emailController.text;
              String password = _passwordController.text;

              print("Email : $email");
              print("Password : $password");

              SharedPrefData.login(email, password);

            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(const SnackBar(content: Text('Logging in...')));
            AppRoute.key.currentState?.pushReplacementNamed(AppRoute.home);
          }
        },
        child: Text("Login"),
      ),
    );
  }

  Widget get _navigateToRegisterButton {
    return TextButton(
      onPressed: () {
        // Navigate to the registration screen
        AppRoute.key.currentState?.pushNamed(AppRoute.register);
      },
      child: const Text(
        "Don't have an account? Register",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
