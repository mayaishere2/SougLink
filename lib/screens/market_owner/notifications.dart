import 'package:flutter/material.dart';
import 'package:souglink/screens/market_owner/mainPageSeller.dart';
import 'SellerDrawer.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isNotificationsSelected = true; // Tracks the active button

  // Dummy data for notifications
  final List<Map<String, String>> notifications = [
    {
      'product': 'الطماطم',
      'time': 'اليوم',
      'message': 'مستوى مخزون منتج الطماطم قارب على النفاد. يرجى التحقق من الكميات المتاحة قريبًا.'
    },
    {
      'product': 'البطاطا',
      'time': 'منذ يومين',
      'message': 'مستوى مخزون منتج البطاطا قارب على النفاد. يرجى التحقق من الكميات المتاحة قريبًا.'
    },
    {
      'product': 'التفاح',
      'time': 'منذ أسبوع',
      'message': 'مستوى مخزون منتج التفاح قارب على النفاد. يرجى التحقق من الكميات المتاحة قريبًا.'
    },
    {
      'product': 'الجزر',
      'time': 'اليوم',
      'message': 'مستوى مخزون منتج الجزر قارب على النفاد. يرجى التحقق من الكميات المتاحة قريبًا.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Group notifications by time period
    Map<String, List<Map<String, String>>> groupedNotifications = {
      'اليوم': [],
      'منذ يومين': [],
      'منذ أسبوع': [],
    };

    for (var notification in notifications) {
      groupedNotifications[notification['time']]?.add(notification);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: the_Drawer(),
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          children: [
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    iconSize: 27,
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: const Text(
                        'الإشعارات',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
            // Notifications container
            Container(
              height: 645,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(127, 255, 255, 255),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Animated Toggle Button
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(128, 26, 103, 14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotificationsSelected = false;
                              });
                              // Navigate to the responses page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPageSeller(activeIndex: 5,)),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: !isNotificationsSelected
                                    ? const Color.fromARGB(255, 15, 75, 6)
                                    : const Color.fromARGB(0, 26, 103, 14),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                'الردود على الطلبات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'NotoSansArabic_SemiCondensed',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotificationsSelected = true;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isNotificationsSelected
                                    ? const Color.fromARGB(255, 15, 75, 6)
                                    : const Color.fromARGB(0, 26, 103, 14),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(15),
                                  bottomLeft: const Radius.circular(15),
                                  topRight: isNotificationsSelected
                                      ? const Radius.circular(15)
                                      : const Radius.circular(0),
                                  bottomRight: isNotificationsSelected
                                      ? const Radius.circular(15)
                                      : const Radius.circular(0),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                'الإشعارات',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NotoSansArabic_SemiCondensed',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: groupedNotifications.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: const Color.fromARGB(255, 15, 75, 6),
                              thickness: 1.5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 15, 75, 6),
                                  fontFamily: 'NotoSansArabic_SemiCondensed',
                                ),
                              ),
                            ),
                            ...entry.value.map((notification) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.notifications_active,
                                        color: Color.fromARGB(255, 176, 48, 39),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          notification['message']!,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily:
                                                'NotoSansArabic_SemiCondensed',
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
