import 'package:amazon_clone/const/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;

  final VoidCallback ontap;
  const CustomButton({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          backgroundColor: GlobalVariables.secondaryColor,
          minimumSize: const Size(double.infinity, 50)),
      child: Text(title),
    );
  }
}
