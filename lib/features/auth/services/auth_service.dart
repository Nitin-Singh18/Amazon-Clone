// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/const/app_keys.dart';
import 'package:amazon_clone/const/error_handling.dart';
import 'package:amazon_clone/const/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
          body: json.encode(user.toJson()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      print(res.body);

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
      print(res.body);

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
