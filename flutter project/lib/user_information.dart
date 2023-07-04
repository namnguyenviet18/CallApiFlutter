

import 'package:first_flutter_app/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInformation extends StatelessWidget {

  UserInformation({
    required this.name,
    required this.address,
    required this.email,
    required this.birth, super.key
  });

  void deleteUserInformation() async{
    SharedPreferences sharedPreferences  = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  String name, address, email, birth;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('User information'),
          backgroundColor: Colors.blue[500],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User name: $name',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'User email: $email',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'User Address: $address',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'User birth: $birth',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  deleteUserInformation();
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text('Log out')
              )
            ],
          ),
        ),
    );
  }

}
