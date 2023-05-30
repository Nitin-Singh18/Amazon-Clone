import 'dart:io';

import 'package:amazon_clone/const/error_handling.dart';
import 'package:amazon_clone/const/global_variables.dart';
import 'package:amazon_clone/const/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProviderToken = context.read<UserProvider>().user.token;
    try {
      //*To upload images to cloudinary to get image Url and we can store
      //*that url in mongoDb

      final cloudinary = CloudinaryPublic("dpiufcdmv", "vjx3dzhf");
      List<String> imageurls = [];
      for (var element in images) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(element.path, folder: name));
        imageurls.add(response.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageurls,
          category: category,
          price: price);

      http.Response response = await http.post(
        Uri.parse(
          '$uri/admin/add-product',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProviderToken
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Successfully.");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}