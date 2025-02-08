import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SellerDrawer.dart';

class ResponsesPage extends StatefulWidget {
  const ResponsesPage({super.key});

  @override
  State<ResponsesPage> createState() => _ResponsesPageState();
}

class _ResponsesPageState extends State<ResponsesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> responses = [];

  @override
  void initState() {
    super.initState();
    _fetchResponses();
  }

  Future<void> _fetchResponses() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('requests')
        .where('buyerId', isEqualTo: user.uid)
        .get();

    List<Map<String, dynamic>> tempResponses = [];

    for (var doc in querySnapshot.docs) {
      var requestData = doc.data();
      var farmerId = requestData['farmerId'];
      
      // Fetch farmer info
      var farmerSnapshot = await FirebaseFirestore.instance.collection('users').doc(farmerId).get();
      var farmerData = farmerSnapshot.data();

      tempResponses.add({
        'id': doc.id,
        'farmerName': farmerData != null ? "${farmerData['firstName']} ${farmerData['lastName']}" : 'مزارع مجهول',
        'product': requestData['product'],
        'quantity': requestData['quantity'],
        'status': requestData['status'],
        'response': requestData.containsKey('responseMessage') 
                      ? requestData['responseMessage'] 
                      : (requestData['status'] == 'accepted' 
                          ? "تم قبول الطلب، يرجى التواصل مع المزارع." 
                          : "تم رفض الطلب."), 
        'timestamp': requestData['timestamp'],
      });
    }

    setState(() {
      responses = tempResponses;
    });
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    'الردود على الطلبات',
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
                  itemCount: responses.length,
                  itemBuilder: (context, index) {
                    return _buildResponseRow(responses[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponseRow(Map<String, dynamic> response) {
    Color containerColor = response['status'] == 'accepted'
        ? Color.fromARGB(117, 26, 103, 14)
        : Color.fromARGB(132, 200, 11, 11);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, color: Colors.black),
          ),
          title: Text(
            response['farmerName'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'NotoSansArabic_SemiCondensed',
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "المنتج: ${response['product']} - الكمية: ${response['quantity']}",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'NotoSansArabic_SemiCondensed',
                ),
              ),
              SizedBox(height: 5),
              Text(
                response['response'],
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'NotoSansArabic_SemiCondensed',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
