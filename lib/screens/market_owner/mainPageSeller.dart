import 'package:flutter/material.dart';
import 'package:souglink/screens/AppBar_drawer_bottomNavBar/farmer_bottom_nav_bar.dart';
import 'package:souglink/screens/login_signup/login_page.dart';
import 'package:souglink/screens/market_owner/Stocklevel.dart';
import 'package:souglink/screens/market_owner/notifications.dart';
import 'package:souglink/screens/market_owner/Homepage.dart';
import 'package:souglink/screens/market_owner/responses_page.dart';
import 'package:souglink/screens/market_owner/search_page.dart';
import 'package:souglink/screens/Profiles/profile.dart';

class MainPageSeller extends StatefulWidget {
  final int activeIndex; // Add this field
   final Map<String, String>? product;
  const MainPageSeller({super.key, required this.activeIndex, this.product});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageSellerState createState() => _MainPageSellerState();
}

class _MainPageSellerState extends State<MainPageSeller> {
  late int _activeIndex;
  
  @override
  void initState() {
    super.initState();
    _activeIndex = widget.activeIndex; // Set the initial value from the widget parameter
  }

  final List<Widget> _basePages = [
    Profile(),
    Stocklevel(),
    SearchPage(),
    ResponsesPage(),
    HomePageSeller(),
    ResponsesPage(),
    LoginPage(), // Updated to use LoginPage
  ];

  @override
  Widget build(BuildContext context) {
    // Dynamically determine the content for the current page
    Widget currentPage;
    if (_activeIndex == 5) {
      currentPage = ResponsesPage();
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