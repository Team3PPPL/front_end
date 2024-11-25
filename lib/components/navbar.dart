import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pppl_apps/constant/appColor.dart';
import 'package:pppl_apps/constant/appFont.dart';
import 'package:pppl_apps/screens/home_page.dart';
import 'package:pppl_apps/screens/cash%20in/income_page.dart';
import 'package:pppl_apps/screens/cash%20out/outcome_page.dart';
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
    const IncomePage(),
    const OutcomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Colors.white, // MEMBERIKAN WARNA BACKGROUND PADA SETIAP HALAMAN
        body: bodyPage[
            selectedPage], // MENAMPILKAN HALAMAN SESUAI DEGAN INDEX YANG SEDANG DIINTAI OLEH SELECTED PAGE

        // MEMBUAT BOTTOM NAVIGATION BAR DENGAN STYLISH BOTTOM BAR
        bottomNavigationBar: StylishBottomBar(
          backgroundColor: componentColors,
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
                  style: selectedPage == 0
                      ? whiteComponentFonts
                      : unselectedComponentFonts,
                ),
                selectedColor: Colors.white),
            BottomBarItem(
                icon: selectedPage == 1
                    ? const Icon(CupertinoIcons.arrow_down_square_fill)
                    : const Icon(CupertinoIcons.arrow_down_square),
                title: Text("Cash In",
                    style: selectedPage == 1
                        ? whiteComponentFonts
                        : unselectedComponentFonts),
                selectedColor: Colors.white),
            BottomBarItem(
                icon: selectedPage == 2
                    ? const Icon(CupertinoIcons.arrow_up_square_fill)
                    : const Icon(CupertinoIcons.arrow_up_square),
                title: Text("Cash Out",
                    style: selectedPage == 2
                        ? whiteComponentFonts
                        : unselectedComponentFonts),
                selectedColor: Colors.white),
            BottomBarItem(
                icon: selectedPage == 3
                    ? const Icon(CupertinoIcons.person_crop_circle_fill)
                    : const Icon(CupertinoIcons.person_crop_circle),
                title: Text("Profile",
                    style: selectedPage == 3
                        ? whiteComponentFonts
                        : unselectedComponentFonts),
                selectedColor: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
