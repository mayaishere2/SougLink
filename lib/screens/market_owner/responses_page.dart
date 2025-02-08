import 'package:flutter/material.dart';
import 'package:souglink/screens/market_owner/mainPageSeller.dart';
import 'SellerDrawer.dart';

class ResponsesPage extends StatefulWidget {
  const ResponsesPage({super.key});

  @override
  State<ResponsesPage> createState() => _ResponsesPageState();
}

class _ResponsesPageState extends State<ResponsesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isNotificationsSelected = false; // Tracks the active button

  // Dummy data for responses
  final List<Map<String, String>> responses = [
    {
      'farmer': 'المزارع علي',
      'response': 'قام المزارع محمد علي بقبول طلب السوق للمنتج. سيتم تجهيز الطلب قريبًا. يرجى التواصل معه لتنسيق التفاصيل.',
      'time': 'اليوم',
      'status': 'accepted', // Accepted request
      'profilePic': 'assets/profile.jpg', // Add a profile image URL
    },
    {
      'farmer': 'المزارع خالد',
      'response': 'لدي 50 كجم من البطاطا بسعر 2 دينار للكيلو.',
      'time': 'منذ يومين',
      'status': 'refused', // Refused request
      'profilePic': 'assets/profile.jpg', // Add a profile image URL
    },
    {
      'farmer': 'المزارع فاطمة',
      'response': 'تم نفاد كمية التفاح حاليًا.',
      'time': 'منذ أسبوع',
      'status': 'refused', // Refused request
      'profilePic': 'assets/profile.jpg', // Add a profile image URL
    },
    {
      'farmer': 'المزارع سعيد',
      'response': 'قام المزارع سعيد بقبول الطلب. سيتم تجهيز 30 كجم من الجزر.',
      'time': 'اليوم',
      'status': 'accepted', // Accepted request
      'profilePic': 'assets/profile.jpg', // Add a profile image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Group responses by time period
    Map<String, List<Map<String, String>>> groupedResponses = {
      'اليوم': [],
      'منذ يومين': [],
      'منذ أسبوع': [],
    };

    for (var response in responses) {
      groupedResponses[response['time']]?.add(response);
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
                        'الردود على الطلبات',
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
            // Responses container
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
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                'الردود على الطلبات',
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotificationsSelected = true;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MainPageSeller(activeIndex: 3)),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isNotificationsSelected
                                    ? const Color.fromARGB(255, 15, 75, 6)
                                    : const Color.fromARGB(0, 26, 103, 14),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                'الإشعارات',
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: groupedResponses.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Color.fromARGB(255, 15, 75, 6),
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 15, 75, 6),
                                  fontFamily: 'NotoSansArabic_SemiCondensed',
                                ),
                              ),
                            ),
                            ...entry.value.map((response) {
                              // Determine the background color based on status
                              Color containerColor = response['status'] == 'accepted'
                                  ? Color.fromARGB(117, 26, 103, 14)
                                  : Color.fromARGB(132, 200, 11, 11);

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: containerColor,
                                  ),
                                  child: Row(
                                    children: [
                                      // Profile Picture
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(response['profilePic']!),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              response['farmer']!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily:
                                                    'NotoSansArabic_SemiCondensed',
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              response['response']!,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily:
                                                    'NotoSansArabic_SemiCondensed',
                                              ),
                                            ),
                                          ],
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
