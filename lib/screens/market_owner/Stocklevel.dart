import 'package:flutter/material.dart';
import 'StockHistory.dart';
import 'package:flutter/services.dart';
import 'SellerDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Stocklevel extends StatefulWidget {
  const Stocklevel({super.key});

  @override
  State<Stocklevel> createState() => _StocklevelState();
}

class _StocklevelState extends State<Stocklevel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String searchText = "";
  bool _showDetails = false;
  String _selectedItem = '';
  String imagePath = 'assets/images/default_image.png';
  String image = '';

  final Map<String, String> productImageMap = {
    "طماطم": "assets/images/tomato.jfif",
    "بطاطا": "assets/potato.jpg",
    "جزر": "assets/images/carrot.jpg",
    "تفاح": "assets/images/apple.jpg",
    "موز": "assets/images/banana.jpg",
    "خيار": "assets/images/cucumber.jpg",
    "ليمون": "assets/images/limon.webp",
  };

  void addItem() async {
    if (nameController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء ملء جميع الحقول')),
      );
      return;
    }

    RegExp arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    if (!arabicRegex.hasMatch(nameController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب إدخال اسم المنتج باللغة العربية فقط')),
      );
      return;
    }

    String productName = nameController.text.trim();
    int amount = int.tryParse(amountController.text) ?? 0;
    String status =
        amount == 0 ? 'نفدت.' : (amount < 10 ? 'منخفضة.' : 'كافية.');

    User? user = FirebaseAuth.instance.currentUser; // Get current user
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب عليك تسجيل الدخول أولاً!')),
      );
      return;
    }

    String userId = user.uid; // Use UID to store user's products

    CollectionReference userProductsRef = FirebaseFirestore.instance
        .collection('users_products')
        .doc(userId)
        .collection('products');

    // Check if the product already exists
    QuerySnapshot query =
        await userProductsRef.where('name', isEqualTo: productName).get();

    if (query.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('هذا المنتج موجود بالفعل!')),
      );
      return;
    }

    // Add new product
    await userProductsRef.add({
      'name': productName,
      'amount': amount,
      'status': status,
      'image': getImagePath(productName),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تمت إضافة المنتج بنجاح!')),
    );

    nameController.clear();
    amountController.clear();
  }

  String getImagePath(String productName) {
    // Trim and normalize the name to avoid whitespace issues
    String formattedName = productName.trim();

    // Check if the product exists in the map
    if (productImageMap.containsKey(formattedName)) {
      return productImageMap[formattedName]!;
    } else {
      return "assets/images/default_image.png"; // Return default image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: the_Drawer(),
        backgroundColor: const Color.fromARGB(255, 228, 243, 226),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: const Alignment(0.5, 0),
                  child: Text(
                    'تحكم في مستويات',
                    style: TextStyle(
                        fontFamily: 'NotoSansArabic_SemiCondensed',
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: const Alignment(-0.5, 0),
                  child: Text(
                    'تخزين المنتجات',
                    style: TextStyle(
                      fontFamily: 'NotoSansArabic_SemiCondensed',
                      fontSize: 32,
                      color: const Color.fromARGB(255, 14, 78, 5),
                      fontWeight: FontWeight.w700,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 35),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'بحث',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(153, 14, 78, 5),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintTextDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'اسم المنتج',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 14, 78, 5),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: TextField(
                              controller: amountController,
                              decoration: InputDecoration(
                                labelText: 'الكمية بالكيلوغرام',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 14, 78, 5),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: addItem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 14, 78, 5),
                          foregroundColor: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text('إضافة المنتج'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    'قائمة المنتجات:',
                    style: TextStyle(
                        fontFamily: 'NotoSansArabic_SemiCondensed',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      var products = snapshot.data!.docs.where((doc) {
                        String name = doc['name'].toString();
                        return searchText.isEmpty || name.contains(searchText);
                      }).toList();

                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          var product = products[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItem = product.id;
                                _showDetails = true;
                              });
                            },
                            child: buildCard(
                              product['name'],
                              '${product['amount']} كج.',
                              product['status'],
                              getImagePath(product['name']),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            if (_showDetails)
              Positioned(
                child: Center(
                  child: StockHistoryPage(
                    selectedItem: _selectedItem, // Pass the selected product ID
                    onClose: () {
                      setState(() {
                        _showDetails = false;
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
      String title, String amount, String status, String imagePath) {
    return Card(
      color: const Color.fromARGB(241, 240, 245, 239),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                SizedBox(width: 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title, $amount',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                          fontSize: 10,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 30,
                  width: 90,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 14, 78, 5), // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12), // Adjust padding as needed
                    child: Text(
                      'المزيد',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kanit',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color.fromARGB(255, 14, 78, 5),
                          title: Text(
                            "تأكيد الحذف",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            "هل أنت متأكد أنك تريد حذف هذا المنتج؟",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                "إلغاء",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 132, 57, 237),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('products')
                                    .where('name', isEqualTo: title)
                                    .get()
                                    .then((snapshot) {
                                  for (var doc in snapshot.docs) {
                                    doc.reference.delete();
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("حذف",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 65,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
