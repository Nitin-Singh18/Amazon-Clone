import 'package:amazon_clone/const/global_variables.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String productImage;
  const ProductTile({super.key, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            productImage,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
