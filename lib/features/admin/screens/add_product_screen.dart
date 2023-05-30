import 'dart:ffi';
import 'dart:io';

import 'package:amazon_clone/common/widgets/c_button.dart';
import 'package:amazon_clone/common/widgets/c_textfield.dart';
import 'package:amazon_clone/const/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../const/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  String category = "Mobiles";
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

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

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

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
          key: _addProductFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
              children: [
                images.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: PageView.builder(itemBuilder: (context, index) {
                          return SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.file(
                              images[index % images.length],
                              fit: BoxFit.fitHeight,
                            ),
                          );
                        }),
                      )
                    : InkWell(
                        onTap: () {
                          selectImages();
                          print("hello");
                        },
                        child: DottedBorder(
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
                                const Icon(Icons.folder_open_outlined),
                                const SizedBox(
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
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                    controller: productNameController,
                    hintText: "Product Name"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(controller: priceController, hintText: "Price"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                    controller: quantityController, hintText: "Quantity"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
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
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    title: "Sell",
                    ontap: () {
                      sellProduct();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
