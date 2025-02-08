import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> requests = [];

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('requests')
        .where('farmerId', isEqualTo: user.uid)
        .get();

    List<Map<String, dynamic>> tempRequests = [];

    for (var doc in querySnapshot.docs) {
      var requestData = doc.data();
      var buyerId = requestData['buyerId'];
      var buyerSnapshot = await FirebaseFirestore.instance.collection('users').doc(buyerId).get();
      var buyerData = buyerSnapshot.data();
      
      tempRequests.add({
        'id': doc.id,
        'buyerName': buyerData != null ? "${buyerData['firstName']} ${buyerData['lastName']}" : 'مستخدم مجهول',
        'product': requestData['product'],
        'quantity': requestData['quantity'],
        'status': requestData['status'],
        'timestamp': requestData['timestamp'],
      });
    }

    setState(() {
      requests = tempRequests;
    });
  }

  void _updateRequestStatus(String requestId, String status) {
    setState(() {
      requests.removeWhere((request) => request['id'] == requestId);
    });
    FirebaseFirestore.instance.collection('requests').doc(requestId).update({'status': status});
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
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(127, 255, 255, 255),
                ),
                child: ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return _buildRequestRow(requests[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestRow(Map<String, dynamic> request) {
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
              onPressed: () {},
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
                      text: request['buyerName'],
                      style: TextStyle(
                        color: Color.fromARGB(255, 15, 75, 6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' شراء ${request['quantity']} من ${request['product']}'),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Color.fromARGB(255, 15, 75, 6), size: 23),
                  onPressed: () => _updateRequestStatus(request['id'], 'accepted'),
                ),
                IconButton(
                  icon: Icon(Icons.clear, color: Color.fromARGB(255, 176, 48, 39), size: 23),
                  onPressed: () => _updateRequestStatus(request['id'], 'rejected'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
