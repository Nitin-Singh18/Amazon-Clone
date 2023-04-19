import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountScreenButton(title: 'Your Orders', onTap: () {}),
            const SizedBox(
              width: 16,
            ),
            AccountScreenButton(title: 'Turn Seller', onTap: () {})
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            AccountScreenButton(title: 'Your Wish List', onTap: () {}),
            const SizedBox(
              width: 14,
            ),
            AccountScreenButton(title: 'Log Out', onTap: () {})
          ],
        )
      ],
    );
  }
}
