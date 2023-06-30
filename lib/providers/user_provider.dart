import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}

class ProductProvider extends ChangeNotifier {
  final List<Product> _productList = [];

  List<Product> get products => _productList;
  void addProduct(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  // Delete a product from the list based on its id
  void deleteProduct(id) {
    _productList.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
