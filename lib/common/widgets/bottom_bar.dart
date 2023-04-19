import 'package:amazon_clone/const/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomNavBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: Text("Account Page"),
    ),
    const Center(
      child: Text("Cart Page"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : Colors.transparent,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : Colors.transparent,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : Colors.transparent,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const badges.Badge(
                badgeContent: Text("2"),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.white,
                  // padding: EdgeInsets.all(0),
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
