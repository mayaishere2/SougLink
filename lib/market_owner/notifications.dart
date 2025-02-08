import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:souglink/market_owner/mainPageSeller.dart';
import 'SellerDrawer.dart';

// Initialize local notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isNotificationsSelected = true; // Tracks the active button
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // List of notifications
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    _initializeFCM();
    _getFCMToken();
  }

  void _getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  }

  Future<void> _initializeFCM() async {
    await Firebase.initializeApp();

    // Request notification permissions (iOS & Android)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notifications: Permission granted");
    } else {
      print("Notifications: Permission denied");
    }

    // Get the FCM token (for backend use)
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");

      String product = message.data['product'] ?? 'منتج مجهول';
      int quantity = int.tryParse(message.data['quantity'] ?? '0') ?? 0;

      if (quantity < 10) {
        _showLocalNotification(RemoteNotification(
          title: "تنبيه المخزون",
          body: "الكمية المتبقية من $product أقل من 10!",
        ));

        setState(() {
          notifications.add({
            'product': product,
            'time': 'الآن',
            'message': "الكمية المتبقية من $product أقل من 10!",
          });
        });
      }
    });

    // Listen for background & terminated messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User opened a notification: ${message.notification?.title}");
    });

    // Initialize local notifications
    _initializeLocalNotifications();
  }

  // Initialize local notifications for displaying notifications while in foreground
  void _initializeLocalNotifications() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show local notification
  Future<void> _showLocalNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
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
                  // Toggle buttons
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainPageSeller(activeIndex: 5)),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: !isNotificationsSelected
                                    ? const Color.fromARGB(255, 15, 75, 6)
                                    : Colors.transparent,
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
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              height: 30,
                              child: const Text(
                                'الإشعارات',
                                style: TextStyle(
                                  color: Colors.black,
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
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
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
                                const Icon(Icons.notifications_active,
                                    color: Color.fromARGB(255, 176, 48, 39)),
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
                      },
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
