// ignore_for_file: prefer_const_constructors

import 'package:amazon_clone/const/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/button.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/top_button.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          title: Column(
            children: [
              Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
              ),
            ],
          ),
          actions: const [
            Icon(Icons.notifications_outlined),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Icon(Icons.search_outlined),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, bottom: 8),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Hello, ',
                      ),
                      TextSpan(
                          text: user.name,
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ]),
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
        child: Column(
          children: const [
            TopButtons(),
            SizedBox(
              height: 20,
            ),
            OrderScreen(),
          ],
        ),
      ),
    );
  }
}
