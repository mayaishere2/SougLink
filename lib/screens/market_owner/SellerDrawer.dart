import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souglink/screens/market_owner/mainPageSeller.dart';
import 'package:souglink/screens/login_signup/login_page.dart';

class the_Drawer extends StatefulWidget {
  const the_Drawer({super.key});

  @override
  State<the_Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<the_Drawer> {
  String userName = 'اسم المستخدم';
  String profilePic = 'assets/profile.jpg';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists && mounted) {
        setState(() {
          String firstName = userDoc['firstName'] ?? '';
          String lastName = userDoc['lastName'] ?? '';
          userName = "$firstName $lastName";

          // ✅ Ensure valid Cloudinary URL
          if (userDoc['profilePic'] != null && userDoc['profilePic'].startsWith('http')) {
            profilePic = userDoc['profilePic'];

            // ✅ Optimize the image (resize, compress)
            profilePic = "$profilePic?w=200&h=200&c=fill&q=80"; 
          } else {
            print("Invalid profilePic path in Firestore, using default.");
            profilePic = "https://your-default-image-url.com"; // Default profile picture
          }
        });
      }
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}




  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: const Color.fromARGB(179, 255, 255, 255),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 180,
                decoration: const BoxDecoration(color: Color.fromARGB(255, 15, 75, 6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: profilePic.startsWith('http')
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.gif', 
                                image: profilePic,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/profile.jpg'); // Fallback
                                },
                              )
                            : Image.asset(profilePic, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              _createDrawerItem(
                icon: Icons.person_2_outlined,
                text: 'الملف الشخصي',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageSeller(activeIndex: 0)));
                },
              ),
              _createDrawerItem(
                icon: Icons.store_mall_directory_outlined,
                text: 'مستويات التخزين',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageSeller(activeIndex: 1)));
                },
              ),
              _createDrawerItem(
                icon: Icons.notifications_active_outlined,
                text: 'الإشعارات و الردود على الطلبات',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageSeller(activeIndex: 3)));
                },
              ),
              _createDrawerItem(
                icon: Icons.settings_outlined,
                text: 'الإعدادات',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageSeller(activeIndex: 4)));
                },
              ),
              _createDrawerItem(
                icon: Icons.logout,
                text: 'تسجيل الخروج',
                onTap: _logout,
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
      padding: const EdgeInsets.all(10),
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFE4F3E2),
        border: const Border(
          bottom: BorderSide(color: Color.fromARGB(255, 15, 75, 6), width: 2.0),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 26),
            const SizedBox(width: 15),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  void _logout() {
    print("Logging out...");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
