import 'package:flutter/material.dart';
import 'package:souglink/screens/market_owner/FarmerProfile.dart';
import 'SellerDrawer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> tabs = ["الاسم", "السعر", "المنتج", "الخدمة", "الموقع"];
  int selectedTab = 0;

  // Dummy data for farmers
  final List<Map<String, String>> farmers = [
    {
      'name': 'علي جابر',
      'city': 'مدينة الجزائر، زرالدة',
      'image': 'assets/profile.jpg', // Correct image path
      'capacity': '10 طن',
    },
    {
      'name': 'سمير عبد العزيز',
      'city': 'مدينة الجزائر، باب الزوار',
      'image': 'assets/profile.jpg', // Correct image path
      'capacity': '15 طن',
    },
    {
      'name':  'فؤاد سعيد ',
      'city': 'مدينة وهران، وهران',
      'image': 'assets/profile.jpg', // Correct image path
      'capacity': '12 طن',
    },
    {
      'name':  'ياسمين علي',
      'city': 'مدينة قسنطينة، قسنطينة',
      'image': 'assets/profile.jpg', // Correct image path
      'capacity': '8 طن',
    },
    {
      'name': 'عبد الله مصطفى الحسن',
      'city': 'مدينة تلمسان، تلمسان',
      'image': 'assets/profile.jpg', // Correct image path
      'capacity': '20 طن',
    },
  ];

  // Filtered list of farmers based on search query
  List<Map<String, String>> filteredFarmers = [];

  @override
  void initState() {
    super.initState();
    filteredFarmers = farmers;
  }

  // Search method to filter farmers by name
  void _searchFarmers(String query) {
    final filtered = farmers.where((farmer) {
      final nameLower = farmer['name']!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredFarmers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: the_Drawer(), // Your custom Drawer widget
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment(1, 1),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: Text(
                          'ابحث عن الفلاح',
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
                            margin: EdgeInsets.only(right: 110),
                            child: Text(
                              'المناسب لك!',
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
                ),
                Container(
                  width: 114,
                  height: 114,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/farmer.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 42,
              width: double.infinity,
              color: Color.fromARGB(255, 15, 75, 6),
              child: Center(
                child: Text(
                  'المزارعين',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 42,
                width: 254,
                child: TextField(
                  onChanged: _searchFarmers, // Call search method on input change
                  decoration: InputDecoration(
                    hintText: 'بحث',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(153, 0, 0, 0),
                    ),
                    suffixIcon: const Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Color.fromARGB(118, 26, 103, 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  tabs.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: 102,
                      child: ChoiceChip(
                        label: Center(
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: selectedTab == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        selected: selectedTab == index,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        selectedColor: Color.fromARGB(255, 15, 75, 6),
                        backgroundColor: Color.fromARGB(118, 26, 103, 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide.none,
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Farmers List
            Expanded(
              child: ListView.builder(
                itemCount: filteredFarmers.length, // Use the filtered list of farmers
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 15, 75, 6),
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 15, 75, 6),
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: AssetImage(filteredFarmers[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(filteredFarmers[index]['name']!, style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', fontSize: 15)),
                      subtitle: Text(filteredFarmers[index]['city']!, style: TextStyle(fontSize: 10)),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigate to the farmer's profile page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Farmerprofile(
                                farmerName: filteredFarmers[index]['name']!,
                                farmerLocation: filteredFarmers[index]['city']!,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'المزيد',
                          style: TextStyle(color: Colors.white, fontFamily: 'NotoSansArabic_SemiCondensed', fontSize: 9),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
