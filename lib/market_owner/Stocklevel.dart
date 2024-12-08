import 'package:flutter/material.dart';
import 'StockHistory.dart';
import 'package:souglink/market_owner/SellerDrawer.dart';

class Stocklevel extends StatefulWidget {
  const Stocklevel({super.key});

  @override
  State<Stocklevel> createState() => _StocklevelState();
}

class _StocklevelState extends State<Stocklevel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  bool _showDetails = false;
  String _selectedItem = '';

  final List<Map<String, dynamic>> items = [
    {
      'title': 'طماطم',
      'amount': '70 كج.',
      'status': 'كافية.',
      'image': 'assets/images/tomato.jfif'
    },
    {
      'title': 'بصل',
      'amount': '10 كج.',
      'status': 'منخفضة.',
      'image': 'assets/images/onion.jfif'
    },
    {
      'title': 'خيار',
      'amount': '0 كج.',
      'status': 'نفدت.',
      'image': 'assets/images/cucumber.jpg'
    },
    {
      'title': 'تفاح',
      'amount': '2 كج.',
      'status': 'منخفضة.',
      'image': 'assets/images/apple.jpg'
    },
    {
      'title': 'ليمون',
      'amount': '15 كج.',
      'status': 'كافية.',
      'image': 'assets/images/limon.webp'
    },
    {
      'title': 'بصل',
      'amount': '15 كج.',
      'status': 'كافية.',
      'image': 'assets/images/onion.jfif'
    },
    {
      'title': 'طماطم',
      'amount': '34 كج.',
      'status': 'كافية.',
      'image': 'assets/images/tomato.jfif'
    },
    {
      'title': 'ليمون',
      'amount': '15 كج.',
      'status': 'كافية.',
      'image': 'assets/images/limon.webp'
    },
  ];

@override
Widget build(BuildContext context) {
  // Filter the items based on the search text
  final filteredItems = items.where((item) {
    final title = item['title'] as String;
    return title.contains(searchText);
  }).toList();

  // Generate the cards for the filtered items
  List<Widget> cards = [];
  for (int i = 0; i < filteredItems.length; ++i) {
    cards.add(buildCard(
      filteredItems[i]['title'],
      filteredItems[i]['amount'],
      filteredItems[i]['status'],
      filteredItems[i]['image'],
    ));
  }

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
                child: ListView(
                  children: cards,
                ),
              ),
            ],
          ),
          if (_showDetails)
            Positioned(
              child: Center(
                child: StockHistoryPage(
                    selectedItem: _selectedItem, items: items),
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
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showDetails = true;
                        _selectedItem = title;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'المزيد',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSansArabic_SemiCondensed',
                        fontSize: 11,
                      ),
                    ),
                  ),
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
