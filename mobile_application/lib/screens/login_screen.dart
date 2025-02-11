// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:mobile_application/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/button.dart';
import '../../widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = "/login-screen";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await Provider.of<UserProvider>(context, listen: false).login(
        _usernameController.text,
        _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully Logged In!',
          ),
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Check username and password again!'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Enhanzer",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.dp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFieldWidget(
                hintText: 'Username',
                labelText: 'Username',
                isPassword: false,
                controller: _usernameController,
                type: "username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFieldWidget(
                hintText: 'Min 8 characters',
                labelText: 'Password',
                isPassword: true,
                controller: _passwordController,
                type: "password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 6.h,
              ),
              ButtonWidget(
                onPressed: _login,
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
