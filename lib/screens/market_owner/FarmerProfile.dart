import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Farmerprofile extends StatefulWidget {
  final String farmerId;
  final String farmerName;
  final String farmerLocation;
  final String farmerImage;

  const Farmerprofile({
    Key? key,
    required this.farmerId,
    required this.farmerName,
    required this.farmerLocation,
    required this.farmerImage,
  }) : super(key: key);

  @override
  State<Farmerprofile> createState() => _FarmerprofileState();
}

class _FarmerprofileState extends State<Farmerprofile> {
  List<Map<String, dynamic>> savedProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchSavedProducts();
  }

  Future<void> _fetchSavedProducts() async {
    FirebaseFirestore.instance
        .collection("user's harvest")
      .doc(widget.farmerId)
      .collection('products')
      .get()
        .then((querySnapshot) {
      if (!mounted) return;
      setState(() {
        savedProducts = querySnapshot.docs.map((doc) {
          var data = doc.data();
          return {
            'name': data['name'] ?? '',
          };
        }).toList();
      });
    }).catchError((error) {
      debugPrint("Error fetching saved products: $error");
    });
  }

   void _requestProduct(String productName) {
    TextEditingController quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('حدد الكمية لـ $productName'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'ادخل الكمية'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                String quantity = quantityController.text;
                if (quantity.isNotEmpty) {
                  _addRequestToFirestore(productName, quantity);
                  Navigator.pop(context);
                }
              },
              child: Text('إرسال'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addRequestToFirestore(String productName, String quantity) async {
    User? user =FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection("requests").add({
        'buyerId': user.uid,
        'farmerId': widget.farmerId,
        'product': productName,
        'quantity': quantity,
        'status': '', // Initially blank until the farmer responds
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        debugPrint("Request added successfully");
      }).catchError((error) {
        debugPrint("Error adding request: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                iconSize: 27,
                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      widget.farmerName,
                      style: const TextStyle(
                        color: Color.fromARGB(191, 15, 75, 6),
                        fontSize: 22,
                        fontFamily: 'NotoSansArabic_SemiCondensed',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.farmerLocation,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'NotoSansArabic_SemiCondensed',
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    widget.farmerImage,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              height: 42,
              width: double.infinity,
              color: const Color.fromARGB(255, 15, 75, 6),
              child: const Center(
                child: Text(
                  'المحاصيل',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: savedProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(148, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 15, 75, 6),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            savedProducts[index]['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 15, 75, 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      
    ),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Smaller padding
    minimumSize: Size(60, 5),
  ),
                            onPressed: () => _requestProduct(savedProducts[index]['name']!),
                            child: Text('طلب', style: TextStyle(color: Colors.white,fontFamily: 'NotoSansArabic_SemiCondensed', fontSize: 10),),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}