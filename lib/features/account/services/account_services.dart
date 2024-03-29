import 'dart:convert';

import 'package:amazon_clone/const/app_keys.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/error_handling.dart';
import '../../../const/global_variables.dart';
import '../../../const/utils.dart';
import '../../../providers/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchOrders(BuildContext context) async {
    final userProvider = context.read<UserProvider>().user.token;

    List<Order> ordersList = [];

    try {
      http.Response response = await http.get(
          Uri.parse(
            "$uri/api/my-orders",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(response.body).length; i++) {
              ordersList.add(
                Order.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ordersList;
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppKeys.token, "");
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
