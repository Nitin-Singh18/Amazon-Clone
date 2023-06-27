// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../const/error_handling.dart';
import '../../../const/global_variables.dart';
import '../../../const/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProdcut(
      BuildContext context, String category) async {
    final userProvider = context.read<UserProvider>().user.token;

    List<Product> productsList = [];

    try {
      http.Response response = await http.get(
          Uri.parse(
            //*the ? character is used in the URI to indicate the start of the
            //*query parameters section
            "$uri/api/products?category=$category",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productsList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  Future<Product> fetchDealOfTheDay(
    BuildContext context,
  ) async {
    final userProvider = context.read<UserProvider>().user.token;
    Product dealOfTheDay = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: "",
        price: 0);

    try {
      http.Response response = await http.get(
          Uri.parse(
            "$uri/api/deal-of-day",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider
          });

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          dealOfTheDay = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return dealOfTheDay;
  }
}
