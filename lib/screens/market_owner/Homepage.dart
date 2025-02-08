import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souglink/screens/market_owner/sellerDrawer.dart';
import 'package:souglink/screens/home_screens/prices_page.dart';
import 'package:souglink/screens/market_owner/FarmerProfile.dart';

class HomePageSeller extends StatefulWidget {
  const HomePageSeller({super.key});

  @override
  State<HomePageSeller> createState() => _HomePageSellerState();
}

class _HomePageSellerState extends State<HomePageSeller> {
  List<Map<String, String>> prices = [];
  List<Map<String, dynamic>> farmers = [];

  @override
  void initState() {
    super.initState();
    _fetchPrices();
    _fetchFarmers();
  }

  Future<void> _fetchPrices() async {
    FirebaseFirestore.instance.collection('Prices').get().then((querySnapshot) {
      if (!mounted) return;
      setState(() {
        prices = querySnapshot.docs.map((doc) {
          var data = doc.data();
          return {
            'name': data['name']?.toString() ?? '',
            'price': data['price']?.toString() ?? '',
          };
        }).toList();
      });
    }).catchError((error) {
      debugPrint("Error fetching prices: $error");
    });
  }

  Future<void> _fetchFarmers() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'مزارع')
        .get()
        .then((querySnapshot) {
      if (!mounted) return;
      setState(() {
        farmers = querySnapshot.docs.map((doc) {
          var data = doc.data();
          return {
  'id': doc.id, // Document ID
  'firstName': data['firstName'] ?? '',
  'lastName': data['lastName'] ?? '',
  'location': data['location'] ?? 'غير متوفر',
  'profilePic': data['profilePic'] ?? 'assets/default_profile.jpg',
};

        }).toList();
      });
    }).catchError((error) {
      debugPrint("Error fetching farmers: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      drawer: the_Drawer(),
      backgroundColor: const Color(0xFFE4F3E2),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSectionTitle('متوسط الأسعار'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: prices.map((priceData) {
                          return _buildPriceCard(context, 'assets/tomato.jpg', priceData['name'] ?? '', priceData['price'] ?? '');
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('المزارعين'),
                    SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: farmers.map((farmer) {
     return _buildFarmerCard(context, farmer);


    }).toList(),
  ),
),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildFarmerCard(BuildContext context, Map<String, dynamic> farmer) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    width: 106,
    height: 145,
    decoration: BoxDecoration(
      color: Color.fromARGB(129, 255, 255, 255),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color.fromARGB(255, 15, 75, 6), width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.transparent, width: 0),
            ),
            child: ClipOval(
              child: Image.network(farmer['profilePic'], fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${farmer['firstName']} ${farmer['lastName']}',
            style: const TextStyle(
              fontFamily: 'NotoSansArabic_SemiCondensed',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 15, 75, 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(50, 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Farmerprofile(
                    farmerId: farmer['id'],
                    farmerName: '${farmer['firstName']} ${farmer['lastName']}',
                    farmerLocation: farmer['location'],
                    farmerImage: farmer['profilePic'],
                  ),
                ),
              );
            },
            child: Text(
              'زيارة',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}


Widget _buildPriceCard(BuildContext context, imagePath, String productName, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 130,
      height: 165,
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(imagePath, height: 55, width: 72, fit: BoxFit.cover)),
            const SizedBox(height: 5),
            Text(
              productName,
              style: const TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: const TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 9,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PricesPage()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 15, 75, 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      
    ),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Smaller padding
    minimumSize: Size(60, 5),
  ),
  child: Text(
    'المزيد',
    
    style: TextStyle(color: Colors.white, fontFamily: 'NotoSansArabic_SemiCondensed', fontSize: 9),
  ),
),

          ],
        ),
      ),
    );
  }


class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

  Widget _buildHeader() {
    return SizedBox(
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipPath(
              clipper: DiagonalClipper(),
              child: Container(
                color: const Color.fromARGB(255, 15, 75, 6),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 300,
            child: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: SizedBox(
              height: 70,
              width: 79,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/logo.png', fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
              top: 160,
              left: 30,
              child: Text(
                'SougLink',
                style: TextStyle(
                  fontFamily: 'Kanit',
                  color: const Color.fromARGB(255, 15, 75, 6),
                  fontSize: 36,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'NotoSansArabic_SemiCondensed',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 15, 75, 6),
          ),
        ),
      ),
    );
  }
