import 'package:flutter/material.dart';
//import 'package:souglink/AppBar_drawer_bottomNavBar/drawer.dart';
import 'package:souglink/farmer/harvest_info.dart';
import 'package:souglink/home_screens/prices_page.dart';

class HomePageFarmer extends StatefulWidget {
  const HomePageFarmer({super.key});

  @override
  State<HomePageFarmer> createState() => _HomePageFarmerState();
}

class _HomePageFarmerState extends State<HomePageFarmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: const Color(0xFFE4F3E2),
      body: Column(
        children: [
          // Custom AppBar with clipped background
          SizedBox(
            height: 200, // Total height for the header
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Diagonal clipped background
                Positioned.fill(
                  child: ClipPath(
                    clipper: DiagonalClipper(),
                    child: Container(
                      color: const Color.fromARGB(255, 15, 75, 6),
                    ),
                  ),
                ),
                // AppBar placed above the diagonal background
                Positioned(
                  top: 10,
                  left: 300,
                  right: 0,
                  child: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ), // Assuming this is your custom AppBar widget
                ),
                Positioned(
                  top: 10,
                  left: 20,
                  child: SizedBox(
                    height: 70,
                    width: 79,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), // Assuming this is your custom AppBar widget
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
          ),
          // Main content scrollable area
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'السوق', // First word
                          style: TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 18,
                            color: const Color.fromARGB(200, 15, 75,
                                6), // Black color for the first word
                          ),
                        ),
                        const SizedBox(width: 5), // Add space between words
                        Text(
                          'عليك', // Second word
                          style: TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 18,
                            color: Colors
                                .black, // Dark green color for the second word
                          ),
                        ),

                        const SizedBox(width: 5), // Add space between words
                        Text(
                          'و اللينك', // Fourth word
                          style: TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 18,
                            color: const Color.fromARGB(200, 15, 75,
                                6), // Dark green color for the fourth word
                          ),
                        ),
                        const SizedBox(width: 5), // Add space between words
                        Text(
                          'علينا', // Fifth word
                          style: TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 18,
                            color:
                                Colors.black, // Black color for the fifth word
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Average Prices Section
                    _buildSectionTitle('متوسط الأسعار'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 200,
                        child: Row(
                          children: List.generate(3, (index) {
                            return Transform.translate(
                              offset: Offset(
                                  0,
                                  (index % 2 == 0)
                                      ? 10.0
                                      : -10.0), // Alternating Y position
                              child: _buildPriceCard('assets/tomato.jpg',
                                  'الطماطم', '20 دج / كغ', index),
                            );
                          }),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Crop Tracking Section
                    _buildSectionTitle('تتبع محاصيل زراعية'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCropButton('assets/tomato.png', 'القمح'),
                        _buildCropButton('assets/potato.jpg', 'البطاطا'),
                        _buildCropButton('assets/tomato.png', 'الطماطم'),
                      ],
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

  Widget _buildPriceCard(
      String imagePath, String productName, String price, int index) {
    // Determine vertical offset for alternating positions
    double verticalOffset = (index % 2 == 0) ? 10.0 : -10.0;

    return Positioned(
      top: 10 + verticalOffset * index, // Alternating Y position
      child: Container(
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
                  child: Image.asset(imagePath,
                      height: 55, width: 72, fit: BoxFit.cover)),
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
              const SizedBox(height: 3),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PricesPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 15, 75, 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(58, 19),
                ),
                child: const Text(
                  'المزيد',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCropButton(String imagePath, String cropName) {
    return Container(
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
                color: const Color.fromARGB(0, 255, 255, 255),
                border:
                    Border.all(color: Color.fromARGB(0, 15, 75, 6), width: 0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              cropName,
              style: const TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 15, 75, 6), // Background color of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Optional: Add rounded corners
                    ),
                    minimumSize: Size(50, 16)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HarvestInfoPage(product: {
                                'name': cropName,
                                'image': imagePath
                              })));
                },
                child: Text(
                  'تتبع',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                    fontSize: 9,
                  ),
                ))
          ],
        ),
      ),
    );
  }
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
