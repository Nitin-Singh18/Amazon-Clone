import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/error_handling.dart';
import '../../../const/global_variables.dart';
import '../../../const/utils.dart';
import '../../../providers/user_provider.dart';

class ProductDetailServices {
  Future<void> rateproduct(
      BuildContext context, double rating, String productId) async {
    final userProvider = context.read<UserProvider>().user.token;

    try {
      print(productId);
      http.Response response = await http.post(
        Uri.parse(
          "$uri/api/rate-product",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider
        },
        body: jsonEncode(
          {'id': productId, 'rating': rating},
        ),
      );
      print(response.body);

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Rated");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
