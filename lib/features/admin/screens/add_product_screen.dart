import 'package:amazon_clone/common/widgets/c_button.dart';
import 'package:amazon_clone/common/widgets/c_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../const/global_variables.dart';

class AddProdcutScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProdcutScreen({super.key});

  @override
  State<AddProdcutScreen> createState() => _AddProdcutScreenState();
}

class _AddProdcutScreenState extends State<AddProdcutScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String category = "Mobiles";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    "Appliances",
    'Books',
    'Fashion',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
              children: [
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open_outlined),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Select product images",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                    controller: productNameController,
                    hintText: "Product Name"),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(controller: priceController, hintText: "Price"),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                    controller: quantityController, hintText: "Quantity"),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map(
                      (e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(
                        () {
                          category = value!;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(title: "Sell", ontap: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
