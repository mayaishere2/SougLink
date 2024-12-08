import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:souglink/farmer/mainPageFarmer.dart';
import 'package:souglink/login_signup/login_page.dart';
import 'package:souglink/home_screens/settings.dart';

class the_Drawer extends StatefulWidget {
  const the_Drawer({super.key});

  @override
  State<the_Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<the_Drawer> {
  String user_name = 'اسم المستخدم';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: Color.fromARGB(179, 255, 255, 255),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 15, 75, 6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.asset(
                          'assets/profile.jpg',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$user_name',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              _createDrawerItem(
                icon: Icons.person_2_outlined,
                text: 'الملف الشخصي',
                onTap: () {
                  // Navigate to FarmerMainPage with active index 0 (Profile)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageFarmer(activeIndex: 0),
                    ),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.store_mall_directory_outlined,
                text: 'مستويات التخزين',
                onTap: () {
                  // Navigate to FarmerMainPage with active index 1 (Storage Levels)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageFarmer(activeIndex: 1),
                    ),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.notifications_active_outlined,
                text: 'الإشعارات و الردود على الطلبات',
                onTap: () {
                  // Navigate to FarmerMainPage with active index 2 (Notifications)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageFarmer(activeIndex: 3),
                    ),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.settings_outlined,
                text: 'الإعدادات',
                onTap: () {
                  // Navigate to FarmerMainPage with active index 3 (Settings)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.logout,
                text: 'تسجيل الخروج',
                onTap: () {
                  // Perform logout action
                  _logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 46,
      decoration: BoxDecoration(
        color: Color(0xFFE4F3E2),
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 15, 75, 6),
            width: 2.0,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 26,
            ),
            SizedBox(width: 15),
            Align(
              alignment: Alignment(0, 0),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Logout function
  void _logout() {
    // Add your logout logic here (e.g., clearing user data, signing out)
    print("Logging out...");
    // After logging out, navigate to the login page or home screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_page(),));
    
  }
}
