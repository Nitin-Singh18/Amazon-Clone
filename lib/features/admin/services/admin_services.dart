// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/const/error_handling.dart';
import 'package:amazon_clone/const/global_variables.dart';
import 'package:amazon_clone/const/utils.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  //To add the products
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
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    List<Product> productsList = [];
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
          onSuccess: () async {
            showSnackBar(context, "Product Added Successfully.");

            productProvider.addProduct(
              Product.fromJson(
                response.body,
              ),
            );

            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //To get all the products
  Future<void>
      // <List<Product>>
      fetchAllProducts(BuildContext context) async {
    final userProvider = context.read<UserProvider>().user.token;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    List<Product> productsList = [];

    try {
      http.Response response = await http.get(
          Uri.parse(
            "$uri/admin/get-products",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          //   for (int i = 0; i < jsonDecode(response.body).length; i++) {
          //     productsList.add(
          //       Product.fromJson(
          //         jsonEncode(
          //           jsonDecode(response.body)[i],
          //         ),
          //       ),
          //     );
          //   }
          // },
          for (var element in jsonDecode(response.body)) {
            productProvider.addProduct(
              Product.fromJson(
                jsonEncode(
                  element,
                ),
              ),
            );
            // productsList.add(
            //   Product.fromJson(
            //     jsonEncode(
            //       element,
            //     ),
            //   ),
            // );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // return productsList;
  }

  //To delete a product
  void deleteProduct(
    BuildContext context,
    Product product,
    VoidCallback onSuccess,
  ) async {
    final userProvider = context.read<UserProvider>().user.token;
    try {
      http.Response response = await http.delete(
        Uri.parse("$uri/admin/delete-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider
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
            onSuccess();
          });
    } catch (e) {}
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final token = context.read<UserProvider>().user.token;

    List<Order> orders = [];

    try {
      http.Response response = await http.get(
          Uri.parse(
            "$uri/admin/get-orders",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              orders.add(
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
    return orders;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final token = context.read<UserProvider>().user.token;
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/admin/update-order-status"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
        body: jsonEncode(
          {
            'id': order.id,
            'status': status,
          },
        ),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
