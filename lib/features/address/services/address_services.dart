import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../const/error_handling.dart';
import '../../../const/global_variables.dart';
import '../../../const/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = context.read<UserProvider>();
    try {
      http.Response response = await http.post(
        Uri.parse(
          '$uri/api/save-user-address',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            User user = userProvider.user.copyWith(
              address: jsonDecode(response.body)['address'],
            );

            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalAmount}) async {
    final userProvider = context.read<UserProvider>();
    try {
      http.Response response = await http.post(
        Uri.parse(
          '$uri/api/order',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'totalAmount': totalAmount,
          'address': address,
          'cart': userProvider.user.cart,
        }),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'Your order has been placed!');

            User user = userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
