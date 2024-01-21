import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../const/global_variables.dart';
import '../../search/screen/search_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View order details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Date:         ${DateFormat().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.order.orderAt),
                        )}",
                      ),
                      Text("Order ID:              ${widget.order.id}"),
                      Text("Total Amount:    \$${widget.order.totalAmount}"),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Purchase Detiails",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Qty: ${widget.order.quantity[i].toString()}",
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text("Pending"),
                      content: const Text('Your order is yet to be delivered.'),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Completed"),
                      content: const Text(
                          'Your order has been delivered, you are yet to sign.'),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Received"),
                      content: const Text(
                          'Your order has been delivered and signed by you.'),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Delivered"),
                      content: const Text(''),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
