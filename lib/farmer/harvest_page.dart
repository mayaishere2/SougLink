import 'package:flutter/material.dart';
import 'farmerDrawer.dart';
import 'package:souglink/farmer/harvest_info.dart';

class HarvestPage extends StatefulWidget {
  const HarvestPage({Key? key}) : super(key: key);

  @override
  State<HarvestPage> createState() => _HarvestPageState();
}

class _HarvestPageState extends State<HarvestPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = '';
  List<Map<String, String>> selectedProducts = []; // Initially empty

  final List<Map<String, String>> availableProducts = [
    {'name': 'طماطم', 'image': 'assets/tomato.jpg'}, // Tomato
    {'name': 'بطاطس', 'image': 'assets/potato.jpg'}, // Potato
    {'name': 'فلفل', 'image': 'assets/potato.jpg'}, // Bell Pepper
    {'name': 'خيار', 'image': 'assets/potato.jpg'}, // Cucumber
    {'name': 'بصل', 'image': 'assets/potato.jpg'}, // Onion
    {'name': 'ثوم', 'image': 'assets/potato.jpg'}, // Garlic
    {'name': 'جزر', 'image': 'assets/potato.jpg'}, // Carrot
    {'name': 'خس', 'image': 'assets/potato.jpg'}, // Lettuce
    {'name': 'فجل', 'image': 'assets/tomato.jpg'}, // Radish
    {'name': 'كوسا', 'image': 'assets/tomato.jpg'}, // Zucchini
    {'name': 'فراولة', 'image': 'assets/tomato.jpg'}, // Strawberry
    {'name': 'تفاح', 'image': 'assets/tomato.jpg'}, // Apple
    {'name': 'برتقال', 'image': 'assets/tomato.jpg'}, // Orange
    {'name': 'عنب', 'image': 'assets/tomato.jpg'}, // Grapes
    {'name': 'موز', 'image': 'assets/tomato.jpg'}, // Banana
    {'name': 'بطيخ', 'image': 'assets/tomato.jpg'}, // Watermelon
    {'name': 'شمام', 'image': 'assets/tomato.jpg'}, // Melon
    {'name': 'رمان', 'image': 'assets/tomato.jpg'}, // Pomegranate
    {'name': 'مانجو', 'image': 'assets/tomato.jpg'}, // Mango
    {'name': 'ليمون', 'image': 'assets/tomato.jpg'}, // Lemon
    {'name': 'أناناس', 'image': 'assets/tomato.jpg'}, // Pineapple
  ];

  void _showProductSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'اختر منتجًا',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed'),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availableProducts.length,
              itemBuilder: (context, index) {
                bool isProductSelected = selectedProducts.any(
                    (product) => product['name'] == availableProducts[index]['name']);

                return ListTile(
                  leading: Image.asset(
                    availableProducts[index]['image']!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    availableProducts[index]['name']!,
                    style: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed'),
                  ),
                  onTap: isProductSelected
                      ? null
                      : () {
                          setState(() {
                            selectedProducts.add(availableProducts[index]);
                          });
                          Navigator.pop(context);
                        },
                  tileColor: isProductSelected ? Colors.grey[300] : null,
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = selectedProducts
        .where((product) => product['name']!.contains(searchQuery))
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: the_Drawer(),
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          children: [
            SizedBox(height: 20,),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 70),
                    Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: const Text(
                        'تتبع',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 60),
                          child: const Text(
                            '   محاصيلك!',
                            style: TextStyle(
                              color: Color.fromARGB(191, 15, 75, 6),
                              fontSize: 22,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 134,
                  height: 114,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/truck.png'),
                      fit: BoxFit.cover,
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
                  itemCount: filteredProducts.isEmpty ? 1 : filteredProducts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == filteredProducts.length || filteredProducts.isEmpty) {
                      return GestureDetector(
                        onTap: _showProductSelectionDialog,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color.fromARGB(255, 15, 75, 6),
                              width: 1,
                            ),
                          ),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(59, 15, 75, 6),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromARGB(255, 15, 75, 6),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 15, 75, 6),
                            ),
                          ),
                        ),
                      );
                    }
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HarvestInfoPage(
                                    product: filteredProducts[index],
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                            ),
                            child: const Text(
                              'عرض تفاصيل',
                              style: TextStyle(
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
