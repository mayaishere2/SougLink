import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int activeIndex; // The index of the active page
  
  const BottomNavBar({super.key, required this.activeIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<IconData> icons = [
    Icons.person_2_outlined, // Icon for the first tab
    Icons.store_mall_directory_outlined,  // Icon for the second tab
    Icons.search,  // Icon for the third tab
    Icons.notifications_active_outlined,  // Icon for the fourth tab
    Icons.home_outlined,  // Icon for the fifth tab
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
              icon: Icon(icons[index], size: 30,), // Change this icon based on your needs
              onPressed: () {
                // Handle navigation or action for each icon
                print('Navigating to page $index');
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
