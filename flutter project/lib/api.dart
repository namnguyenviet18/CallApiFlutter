
import 'dart:convert';

import 'dart:io';


import 'package:crypto/crypto.dart';
import 'package:first_flutter_app/const.dart';
import 'package:first_flutter_app/showdialog.dart';
import 'package:first_flutter_app/user_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  static void call(BuildContext context, String email, String password) async{
    String url = "http://lms-school-node1.vnpt.edu.vn/service/security/loginJWT";
    String urlProfile = "http://lms-school-node1.vnpt.edu.vn/service/user/getUserProfile";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Constants.LOGGED, false);
    sharedPreferences.setBool(Constants.IS_LOGIN_SUCCESS, false);
    Response response = await post(
        Uri.parse(url),
        body: {
          Constants.USER_EMAIL: email,
          Constants.USER_PASSWORD: md5.convert(utf8.encode(password)).toString()
        }
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      if (data[Constants.SUCCESS]) {
        sharedPreferences.setString(
            Constants.TO_KEN, data[Constants.DATA][Constants.TO_KEN]);
        sharedPreferences.setBool(Constants.IS_LOGIN_SUCCESS, true);
        Response fetchUser = await post(
            Uri.parse(urlProfile),
            headers: <String, String>{
              Constants.AUTHORIZATION: data[Constants.DATA][Constants.TO_KEN]
            },
            body: {}
        );
        if (fetchUser.statusCode == 200) {
          var information = jsonDecode(fetchUser.body.toString());
          if (information[Constants.SUCCESS]) {
            

            sharedPreferences.setString(Constants.USER_NAME,
                information[Constants.DATA][Constants.USER_PROFILE][Constants
                    .USER_NAME]);
            sharedPreferences.setString(Constants.USER_EMAIL,
                information[Constants.DATA][Constants.USER_PROFILE][Constants
                    .USER_EMAIL]);
            sharedPreferences.setString(Constants.USER_BIRTH_DAY,
                information[Constants.DATA][Constants.USER_PROFILE][Constants
                    .USER_BIRTH_DAY]);
            sharedPreferences.setString(Constants.USER_ADDRESS,
                information[Constants.DATA][Constants.USER_PROFILE][Constants
                    .USER_ADDRESS]);
            sharedPreferences.setBool(Constants.LOGGED, true);

            String name = '', emailU = '', address = '', birth = '';
            name = sharedPreferences.getString(Constants.USER_NAME)!;
            emailU = sharedPreferences.getString(Constants.USER_EMAIL)!;
            address = sharedPreferences.getString(Constants.USER_ADDRESS)!;
            birth = sharedPreferences.getString(Constants.USER_BIRTH_DAY)!;

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return UserInformation(
                      name: name,
                      address: address,
                      email: emailU,
                      birth: birth
                  );
                }
              )
            );
          }
        }
      }else {
        sharedPreferences.setString(Constants.MSG, data[Constants.MSG]);
        showMyDialog.show(context, Constants.CALL_FAIL, sharedPreferences.getString(Constants.MSG));
      }
    }
  }

  static Future<void> capCha() async {
    String url = 'http://lms-school-node1.vnpt.edu.vn/test/resetCaptcha?key=c373d05adf87625818d1a478b59975f93ff9c95544910f1b2863a5899882b53f&captchaKey=loginForm';
    Response response = await post(
      Uri.parse(url),
      body: {}
    );
  }


}