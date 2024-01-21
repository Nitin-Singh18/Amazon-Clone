import 'package:amazon_clone/features/account/widgets/product_tile.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServices _adminServices = AdminServices();
  List<Order>? orders;
  @override
  void initState() {
    super.initState();
    getAllOrder();
  }

  void getAllOrder() async {
    orders = await _adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final order = orders![index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, OrderDetailsScreen.routeName,
                    arguments: order),
                child: SizedBox(
                  height: 140,
                  child: ProductTile(
                    productImage: order.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
