

import 'dart:async';
import 'dart:convert';


import 'package:first_flutter_app/const.dart';
import 'package:first_flutter_app/login.dart';
import 'package:first_flutter_app/user_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  late final Widget nextWidget;
  Future<void> setWidget() async {
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(Constants.TO_KEN);
    if(token != null && token.isNotEmpty ) {
      String name = '', emailU = '', address = '', birth = '';
      name = sharedPreferences.getString(Constants.USER_NAME)!;
      emailU = sharedPreferences.getString(Constants.USER_EMAIL)!;
      address = sharedPreferences.getString(Constants.USER_ADDRESS)!;
      birth = sharedPreferences.getString(Constants.USER_BIRTH_DAY)!;

      nextWidget = UserInformation(name: name, address: address, email: emailU, birth: birth);
    } else {
      nextWidget =  const Login();
    }
  }


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      setWidget();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextWidget));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/img_1.png'),
              width: 300,
            ),
            SizedBox(height: 50,),
            SpinKitCircle(
              color: Colors.orange,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
