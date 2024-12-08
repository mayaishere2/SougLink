import 'package:flutter/material.dart';
import 'package:souglink/AppBar_drawer_bottomNavBar/farmer_bottom_nav_bar.dart';
import 'package:souglink/farmer/SearchPage.dart';
import 'package:souglink/farmer/harvest_info.dart';
import 'package:souglink/farmer/harvest_page.dart';
import 'package:souglink/farmer/requests.dart';
import 'package:souglink/home_screens/home_screen.dart';
import 'package:souglink/farmer/profile.dart';

class MainPageFarmer extends StatefulWidget {
  final int activeIndex; // Add this field
   final Map<String, String>? product;
  const MainPageFarmer({super.key, required this.activeIndex, this.product});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageFarmerState createState() => _MainPageFarmerState();
}

class _MainPageFarmerState extends State<MainPageFarmer> {
  late int _activeIndex;
  
  @override
  void initState() {
    super.initState();
    _activeIndex = widget.activeIndex; // Set the initial value from the widget parameter
  }

  final List<Widget> _basePages = [
    Profile(),
    HarvestPage(),
    SearchPage(),
    RequestPage(),
    HomePageFarmer(),
  ];

  @override
  Widget build(BuildContext context) {
    // Dynamically determine the content for the current page
    Widget currentPage;
    if (_activeIndex == 5 && widget.product != null) {
      currentPage = HarvestInfoPage(product: widget.product!);
    } else {
      currentPage = _basePages[_activeIndex];
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 243, 226),
      body: currentPage,
      bottomNavigationBar: FarmerBottomNavBar(
        activeIndex: _activeIndex,
        onPageChanged: (index) {
          setState(() {
            _activeIndex = index; // Update the active page
          });
        },
      ),
    );
  }
}