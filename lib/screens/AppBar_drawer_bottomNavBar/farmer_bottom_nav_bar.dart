import 'package:flutter/material.dart';
import 'package:souglink/screens/farmer/harvest_page.dart';
import 'package:souglink/screens/farmer/searchPage.dart';
import 'package:souglink/screens/Profiles/FarmerProfile.dart';
import 'package:souglink/screens/home_screens/home_screen.dart';
import 'package:souglink/screens/farmer/requests.dart';

class FarmerBottomNavBar extends StatefulWidget {
  final int activeIndex;
  final Function(int) onPageChanged; // Callback to update the active page

  const FarmerBottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onPageChanged,
  });

  @override
  State<FarmerBottomNavBar> createState() => _FarmerBottomNavBarState();
}

class _FarmerBottomNavBarState extends State<FarmerBottomNavBar> {
  final List<IconData> icons = [
    Icons.person_2_outlined, // Icon for the first tab (Profile)
    Icons.store_mall_directory_outlined, // Icon for the second tab (Market)
    Icons.search, // Icon for the third tab (Search)
    Icons.notifications_active_outlined, // Icon for the fourth tab (Notifications)
    Icons.home_outlined, // Icon for the fifth tab (Home)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: EdgeInsets.only(top: 13, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        border: Border(
          top: BorderSide(color: Color.fromARGB(255, 15, 75, 6), width: 1),
          right: BorderSide(color: Color.fromARGB(255, 15, 75, 6), width: 1),
          left: BorderSide(color: Color.fromARGB(255, 15, 75, 6), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          return Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: widget.activeIndex == index
                  ? Color.fromARGB(255, 15, 75, 6) // Dark green for active index
                  : Colors.transparent, // Transparent for inactive index
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(icons[index], size: 30),
              onPressed: () {
              print('Tab $index clicked');
                widget.onPageChanged(index); // Update the page index when clicked
              },
              color: widget.activeIndex == index
                  ? Colors.white // White icon for active page
                  : Colors.black, // Black icon for inactive pages
            ),
          );
        }),
      ),
    );
  }
}

class FarmerMainPage extends StatefulWidget {
  const FarmerMainPage({super.key});

  @override
  _FarmerMainPageState createState() => _FarmerMainPageState();
}

class _FarmerMainPageState extends State<FarmerMainPage> {
  int _activeIndex = 0; // To track the current active tab

  final List<Widget> _pages = [
    // List of pages for each tab
    Profile(), // First tab - Profile
    HarvestPage(), // Second tab - Market
    SearchPage(), // Third tab - Search
    RequestPage(), // Fourth tab - Notifications
    HomePageFarmer(), // Fifth tab - Home
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard', style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed')),
        backgroundColor: const Color.fromARGB(255, 15, 75, 6), // Dark green
      ),
      body: _pages[_activeIndex], // Display the selected page
      bottomNavigationBar: FarmerBottomNavBar(
        activeIndex: _activeIndex,
        onPageChanged: (index) {
          setState(() {
            _activeIndex = index; // Update the active index when a tab is clicked
          });
        },
      ),
    );
  }
}