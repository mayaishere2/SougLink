import 'dart:ui';
import 'package:flutter/material.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({super.key});

  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/tomato.jpg',
      'product': 'المنتج: طماطم',
      'price': '1 كغ: 70.00 دج',
    },
    {
      'image': 'assets/potato.jpg',
      'product': 'المنتج: بطاطا',
      'price': '1 كغ: 100.00 دج',
    },
    {
      'image': 'assets/potato.jpg',
      'product': 'المنتج: بطاطا',
      'price': '1 كغ: 100.00 دج',
    },
    {
      'image': 'assets/tomato.jpg',
      'product': 'المنتج: طمطم',
      'price': '1 كغ: 70.00 دج',
    },
  ];

  // Create a TextEditingController to manage the search input
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items; // Initially show all items
    _searchController.addListener(_filterItems); // Add listener to update filtered items
  }

  // Filter the items based on the search query
  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) {
        return item['product']!.toLowerCase().contains(query); // Filter items based on product name
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFE4F3E2),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFE4F3E2),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 22),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'اطلع على متوسط أسعار ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'NotoSansArabic_SemiCondensed',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'المنتجات في منطقتك',
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 75, 6),
                      fontSize: 28,
                      fontFamily: 'NotoSansArabic_SemiCondensed',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 42,
                width: 320,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'بحث',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(153, 0, 0, 0),
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Color.fromARGB(145, 26, 103, 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 30.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(127, 255, 255, 255),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              item['image']!,
                              height: 70,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['product']!,
                                    style: TextStyle(
                                      fontFamily: 'NotoSansArabic_SemiCondensed',
                                      fontSize: 9,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    item['price']!,
                                    style: TextStyle(
                                      fontFamily: 'NotoSansArabic_SemiCondensed',
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 15, 75, 6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
