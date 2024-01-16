import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../const/error_handling.dart';
import '../../../const/global_variables.dart';
import '../../../const/utils.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class CartServices {
  Future<void> removeFromCart(BuildContext context, Product product) async {
    final userProvider = context.read<UserProvider>();
    print("removed called");
    try {
      http.Response response = await http.delete(
        Uri.parse(
          "$uri/api/remove-from-cart/${product.id}",
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
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
}
