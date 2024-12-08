import 'package:flutter/material.dart';

class SellerProfilePage extends StatelessWidget {
  final String sellerName;
  final String sellerLocation;
  final String sellerRating;
  final String profileImage;
  final List<Map<String, String>> previousSales;

  const SellerProfilePage({
    super.key,
    required this.sellerName,
    required this.sellerLocation,
    required this.sellerRating,
    required this.profileImage,
    required this.previousSales,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'بروفايل $sellerName',
          style: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed'),
        ),
        backgroundColor: const Color.fromARGB(0, 15, 75, 6), // Dark green
      ),
      backgroundColor: const Color(0xFFE4F3E2), // Light green background
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seller information section (with profile image)
            Container(
              
              color: Colors.transparent, // Transparent background
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sellerName,
                          style: const TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 15, 75, 6),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Color.fromARGB(255, 15, 75, 6)),
                            const SizedBox(width: 5),
                            Text(
                              sellerLocation,
                              style: const TextStyle(
                                fontFamily: 'NotoSansArabic_SemiCondensed',
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 5),
                            Text(
                              'التقييم: $sellerRating',
                              style: const TextStyle(
                                fontFamily: 'NotoSansArabic_SemiCondensed',
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(profileImage), // Use an image URL or asset
                      backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Dark green divider
            Container(
              height: 2,
              color: const Color.fromARGB(255, 15, 75, 6), // Dark green line
            ),
            const SizedBox(height: 20),
            // Previous sales section
            Text(
              'المبيعات السابقة',
              style: const TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 15, 75, 6),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: previousSales.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                        child: const Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                      title: Text(
                        previousSales[index]['product']!,
                        style: const TextStyle(
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'الكمية: ${previousSales[index]['quantity']} كجم\nالتاريخ: ${previousSales[index]['date']}',
                        style: const TextStyle(
                          fontFamily: 'NotoSansArabic_SemiCondensed',
                          fontSize: 14,
                          color: Colors.grey,
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
