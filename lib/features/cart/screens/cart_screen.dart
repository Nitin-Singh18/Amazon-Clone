import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/c_button.dart';
import '../../../const/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../home/widgets/address_box.dart';
import '../../search/screen/search_screen.dart';
import '../widgets/cart_product.dart';
import '../widgets/cart_subtotal.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 15),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 1,
              child: TextFormField(
                onFieldSubmitted: (value) => Navigator.pushNamed(
                    context, SearchScreen.routeName,
                    arguments: value),
                decoration: const InputDecoration(
                  prefixIcon: InkWell(
                    // onTap: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(top: 10),
                  hintText: "Search Amazon.in",
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.mic,
                color: Colors.black,
                size: 25,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const AddressBox(),
          const CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              title: 'Proceed to Buy (${user.cart.length}) items',
              ontap: () => Navigator.pushNamed(context, AddressScreen.routeName,
                  arguments: sum.toString()),
              color: Colors.yellow.shade600,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            color: Colors.black12.withOpacity(0.08),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: user.cart.length,
              itemBuilder: (BuildContext context, int index) {
                return CartProduct(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
