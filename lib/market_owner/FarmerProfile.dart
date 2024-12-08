import 'package:flutter/material.dart';
import 'sellerDrawer.dart';
import 'package:souglink/farmer/harvest_info.dart';

class Farmerprofile extends StatefulWidget {
  final String farmerName;
  final String farmerLocation;

  // Constructor to accept name and location
  const Farmerprofile({
    Key? key,
    required this.farmerName,
    required this.farmerLocation,
  }) : super(key: key);

  @override
  State<Farmerprofile> createState() => _FarmerprofileState();
}

class _FarmerprofileState extends State<Farmerprofile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = '';

  // List to store product requests
  List<Map<String, dynamic>> requests = [];

  // Initially, populate selectedProducts with availableProducts.
  List<Map<String, String>> selectedProducts = [
    {'name': 'طماطم', 'image': 'assets/tomato.jpg'},
    {'name': 'بطاطس', 'image': 'assets/potato.jpg'},
    {'name': 'فلفل', 'image': 'assets/potato.jpg'},
    {'name': 'خيار', 'image': 'assets/potato.jpg'},
    {'name': 'بصل', 'image': 'assets/potato.jpg'},
    {'name': 'ثوم', 'image': 'assets/potato.jpg'},
    {'name': 'جزر', 'image': 'assets/potato.jpg'},
    {'name': 'خس', 'image': 'assets/potato.jpg'},
    {'name': 'فجل', 'image': 'assets/tomato.jpg'},
    {'name': 'كوسا', 'image': 'assets/tomato.jpg'},
    {'name': 'فراولة', 'image': 'assets/tomato.jpg'},
    {'name': 'تفاح', 'image': 'assets/tomato.jpg'},
    {'name': 'برتقال', 'image': 'assets/tomato.jpg'},
    {'name': 'عنب', 'image': 'assets/tomato.jpg'},
    {'name': 'موز', 'image': 'assets/tomato.jpg'},
    {'name': 'بطيخ', 'image': 'assets/tomato.jpg'},
    {'name': 'شمام', 'image': 'assets/tomato.jpg'},
    {'name': 'رمان', 'image': 'assets/tomato.jpg'},
    {'name': 'مانجو', 'image': 'assets/tomato.jpg'},
    {'name': 'ليمون', 'image': 'assets/tomato.jpg'},
    {'name': 'أناناس', 'image': 'assets/tomato.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = selectedProducts
        .where((product) => product['name']!.contains(searchQuery))
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          children: [
            SizedBox(height: 20),
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
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 0),
                          child: Text(
                            widget.farmerName,  // Use widget.farmerName
                            style: const TextStyle(
                              color: Color.fromARGB(191, 15, 75, 6),
                              fontSize: 22,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 0),
                          child: Text(
                            widget.farmerLocation,  // Use widget.farmerLocation
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Display farmer's profile picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 114,
                    height: 114,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/profile.jpg'), // Replace with farmer's image
                        fit: BoxFit.cover,
                      ),
                    ),
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
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 42,
                width: 254,
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'بحث',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(153, 0, 0, 0),
                    ),
                    suffixIcon: const Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: const Color.fromARGB(118, 26, 103, 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: filteredProducts.isEmpty ? 0 : filteredProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(148, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color.fromARGB(255, 15, 75, 6),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            filteredProducts[index]['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            filteredProducts[index]['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Show quantity input dialog
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'حدد الكمية',
                                      style: TextStyle(
                                        color: Color.fromARGB(191, 15, 75, 6),
                                        fontFamily: 'NotoSansArabic_SemiCondensed',
                                      ),
                                    ),
                                    content: TextField(
                                      cursorColor: Color.fromARGB(191, 15, 75, 6),
                                      onChanged: (query) {
                                        setState(() {
                                          searchQuery = query;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: '',
                                        hintStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(153, 0, 0, 0),
                                        ),
                                        suffixIcon: const Icon(Icons.search, color: Colors.black),
                                        filled: true,
                                        fillColor: const Color.fromARGB(32, 26, 103, 14),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('إلغاء', style: TextStyle(
                                          fontFamily: 'NotoSansArabic_SemiCondensed',
                                          color: Color.fromARGB(191, 15, 75, 6),
                                        )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Add the request with the specified quantity
                                          requests.add({
                                            'product': filteredProducts[index]['name']!,
                                            'quantity': '1', // You can update this value to the inputted quantity
                                          });
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text('إرسال', style: TextStyle(color: Color.fromARGB(191, 15, 75, 6),
                                          fontFamily: 'NotoSansArabic_SemiCondensed',),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(80, 26), // Smaller button size
                              backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                            ),
                            child: const Text(
                              'طلب',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'NotoSansArabic_SemiCondensed',
                                color: Colors.white,
                              ),
                            ),
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
