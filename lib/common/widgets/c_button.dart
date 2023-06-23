import 'package:amazon_clone/const/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;

  final VoidCallback ontap;
  final Color color;
  const CustomButton(
      {super.key,
      required this.title,
      required this.ontap,
      this.color = GlobalVariables.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: const Size(double.infinity, 50)),
      child: Text(title),
    );
  }
}
