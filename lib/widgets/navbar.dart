import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/screens/home_page.dart';
import 'package:pppl_apps/screens/income_page.dart';
import 'package:pppl_apps/screens/outcome_page.dart';
import 'package:pppl_apps/screens/profile_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedPage = 0;

  List bodyPage = [
    const HomePage(),
    const OutcomePage(),
    const IncomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: bodyPage[selectedPage],
        bottomNavigationBar: StylishBottomBar(
          backgroundColor: universalColors,
          currentIndex: selectedPage,
          option: AnimatedBarOptions(
              iconSize: 35, padding: const EdgeInsets.symmetric(vertical: 5)),
          items: [
            BottomBarItem(
                icon: selectedPage == 0
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home_outlined),
                title: Text(
                  "Home",
                  style: componentFonts,
                ),
                selectedColor: Colors.white),
            BottomBarItem(
                icon: const Icon(CupertinoIcons.sort_up_circle),
                title: Text("Cash Out", style: componentFonts),
                selectedColor: Colors.white),
            BottomBarItem(
                icon: const Icon(CupertinoIcons.arrow_down_square),
                title: Text("Cash In", style: componentFonts),
                selectedColor: Colors.white),
            BottomBarItem(
                icon: const Icon(CupertinoIcons.profile_circled),
                title: Text("Profile", style: componentFonts),
                selectedColor: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              selectedPage = index;
              // selectedNavbar = false;
            });
          },
        ));
  }
}
