// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/const/app_keys.dart';
import 'package:amazon_clone/const/error_handling.dart';
import 'package:amazon_clone/const/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/global_variables.dart';

class AuthService {
  //Sign Up User
  Future<void> signUpUser(
      String email, String password, String name, BuildContext context) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: json.encode(user.toMap()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Sign In User
  Future<void> signInUser(
      String email, String password, BuildContext context) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            AppKeys.email: email,
            AppKeys.password: password,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(AppKeys.token, jsonDecode(res.body)['token']);
            print(prefs.getString(AppKeys.token));
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      print(e.toString());

      showSnackBar(context, e.toString());
    }
  }

  //get user data
  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppKeys.token);

      if (token == null) {
        prefs.setString(AppKeys.token, "");
      }
      print("work");
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          AppKeys.token: token!,
        },
      );

      var response = jsonDecode(tokenRes.body);
      print("token response : ${response}");
      if (response == true) {
        //get user data
        print("user");
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            AppKeys.token: token,
          },
        );
        print(userRes.body);

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        //*Error
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
