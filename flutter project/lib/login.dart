

import 'package:first_flutter_app/api.dart';

import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidAccount = false;

  bool isValidDetails() {
    if(userNameController.text.isEmpty) {
      return false;
    }else if(passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.black87
            ),
          ),
          const SizedBox(height: 50,),
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30,),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 50,),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  CallApi.capCha();
                });
                if(isValidDetails()) {
                  CallApi.call(context, userNameController.text, passwordController.text);
                }
              },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              elevation: 10,
              shadowColor: Colors.black87
            ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
          )
        ],
      )
    ),
    );
  }
}


