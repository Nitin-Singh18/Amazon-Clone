// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/error_handling.dart';
import '../../../const/global_variables.dart';
import '../../../const/utils.dart';
import '../../../providers/user_provider.dart';

class ProductDetailServices {
  Future<void> addToCart(BuildContext context, Product product) async {
    final userProvider = context.read<UserProvider>();

    try {
      http.Response response = await http.post(
        Uri.parse(
          "$uri/api/add-to-cart",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> rateproduct(
      BuildContext context, double rating, String productId) async {
    final userProvider = context.read<UserProvider>().user.token;

    try {
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
