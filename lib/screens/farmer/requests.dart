import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'farmerDrawer.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Dummy data for requests with user info, product, quantity, and time
  final List<Map<String, String>> requests = [
    {'username': 'أحمد علي', 'product': 'الطماطم', 'quantity': '12 كيلوغرام', 'time': '3 سا'},
    {'username': 'محمد حسين', 'product': 'البطاطا', 'quantity': '5 كيلوغرام', 'time': '2 days ago'},
    {'username': 'سارة جابر', 'product': 'الخيارات', 'quantity': '7 كيلوغرام', 'time': '1 week ago'},
    {'username': 'علي عبد الله', 'product': 'الذرة', 'quantity': '10 كيلوغرام', 'time': 'today'},
    {'username': 'محمود أحمد', 'product': 'الجزر', 'quantity': '15 كيلوغرام', 'time': '2 days ago'},
    {'username': 'جميلة حسن', 'product': 'الباذنجان', 'quantity': '8 كيلوغرام', 'time': 'today'},
    {'username': 'كريم صالح', 'product': 'التفاح', 'quantity': '20 كيلوغرام', 'time': '1 week ago'},
  ];

  // List to store accepted requests
  final List<Map<String, String>> acceptedRequests = [];
  @override
  Widget build(BuildContext context) {
    // Group requests by time period
    Map<String, List<Map<String, String>>> groupedRequests = {
      'today': [],
      '2 days ago': [],
      '1 week ago': [],
    };

    for (var request in requests) {
      groupedRequests[request['time']]?.add(request);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: the_Drawer(),
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          children: [
            SizedBox(height: 18.1),
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
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'الطلبات',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // The notifications container
            Container(
              height: 645,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(127, 255, 255, 255),
              ),
              child: ListView(
                children: [
                  if (groupedRequests['today']!.isNotEmpty)
                    _buildSection('اليوم', groupedRequests['today']!),
                  if (groupedRequests['2 days ago']!.isNotEmpty)
                    _buildSection('منذ يومين', groupedRequests['2 days ago']!),
                  if (groupedRequests['1 week ago']!.isNotEmpty)
                    _buildSection('منذ أسبوع', groupedRequests['1 week ago']!),
                ],
              ),
            ),
          ],
        ),
    ),);
  }

  Widget _buildSection(String title, List<Map<String, String>> requests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 15, 75, 6),
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSansArabic_SemiCondensed',
            ),
          ),
        ),
        Divider(
          color: Color.fromARGB(255, 15, 75, 6),
          thickness: 2,
          height: 0,
        ),
        for (var request in requests) _buildRequestRow(request),
      ],
    );
  }

  Widget _buildRequestRow(Map<String, String> request) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(209, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.notifications_active, color: Color.fromARGB(255, 176, 48, 39)),
              onPressed: () {
                // Handle notifications
              },
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'طلب من '),
                    TextSpan(
                      text: request['username'],
                      style: TextStyle(
                        color: Color.fromARGB(255, 15, 75, 6),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfilePage(username: request['username']!),
                          ),
                        );
                      },
                    ),
                    TextSpan(text: ' شراء ${request['quantity']} من ${request['product']}. ${request['time']}'),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Color.fromARGB(255, 15, 75, 6), size: 23),
                  onPressed: () {
                    setState(() {
                      acceptedRequests.add(request);
                      this.requests.remove(request);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.clear, color: const Color.fromARGB(255, 176, 48, 39), size: 23),
                  onPressed: () {
                    setState(() {
                      this.requests.remove(request);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy profile page for navigation
class UserProfilePage extends StatelessWidget {
  final String username;

  const UserProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile of $username')),
      body: Center(
        child: Text('Profile details of $username'),
      ),
    );
  }
}
