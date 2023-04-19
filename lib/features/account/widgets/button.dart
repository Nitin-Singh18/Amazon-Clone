import 'package:flutter/material.dart';

class AccountScreenButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const AccountScreenButton(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: onTap,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
            )),
      ),
    );
  }
}
