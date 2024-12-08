import 'package:flutter/material.dart';
import 'farmerDrawer.dart';
import 'package:souglink/farmer/SellerProfilePage.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  // Placeholder data for market sellers
final List<Map<String, String>> marketSellers = [
  {'name': 'أحمد الجندي', 'product': 'طماطم', 'location': 'الجزائر', 'rating': '4.5'},
  {'name': 'سارة العسلي', 'product': 'بطاطا', 'location': 'وهران', 'rating': '4.0'},
  {'name': 'يوسف طه', 'product': 'بصل', 'location': 'قسنطينة', 'rating': '4.8'},
  {'name': 'فاطمة الزهراء', 'product': 'خيار', 'location': 'المدية', 'rating': '4.7'},
  {'name': 'محمود الصالح', 'product': 'جزر', 'location': 'عنابة', 'rating': '4.3'},
];

  // Filtered market sellers based on search query
  List<Map<String, String>> filteredMarketSellers = [];

  // Placeholder data for past customers
final List<Map<String, String>> pastCustomers = [
  {'name': 'محمد علي', 'purchase': '10 كجم من الطماطم', 'image': 'assets/customer_a.png'},
  {'name': 'هالة صادق', 'purchase': '5 كجم من البطاطا', 'image': 'assets/customer_b.png'},
  {'name': 'أمينة عبد الله', 'purchase': '15 كجم من البصل', 'image': 'assets/customer_c.png'},
  {'name': 'سمير توفيق', 'purchase': '20 كجم من الخيار', 'image': 'assets/customer_d.png'},
  {'name': 'ليلى عبد الرحمن', 'purchase': '7 كجم من الجزر', 'image': 'assets/customer_e.png'},
];
  @override
  void initState() {
    super.initState();
    filteredMarketSellers = marketSellers; // Initially show all sellers
  }

  void _filterSellers(String query) {
    setState(() {
      filteredMarketSellers = marketSellers
          .where((seller) =>
              seller['name']!.contains(query) ||
              seller['product']!.contains(query) ||
              seller['location']!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: the_Drawer(),
      appBar: AppBar( 
        title: Padding(
          padding: const EdgeInsets.only(right: 60.0),
          child: const Text('بحث عن بائعين السوق', style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed')),
        ),
        backgroundColor: const Color(0xFFE4F3E2),
         // Dark green
      ),
      backgroundColor: const Color(0xFFE4F3E2), // Light green background
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: _filterSellers,
              decoration: InputDecoration(
                hintText: 'ابحث',
                hintStyle: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 15, 75, 6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 15, 75, 6)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Search results section
            Text(
              'نتائج البحث',
              style: const TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 15, 75, 6),
              ),
            ),
            const SizedBox(height: 10),
            // Market seller cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredMarketSellers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerProfilePage(
                            sellerName: filteredMarketSellers[index]['name']!, // Use data from the list
                            sellerLocation: filteredMarketSellers[index]['location']!,
                            sellerRating: filteredMarketSellers[index]['rating']!,
                            profileImage: 'https://www.example.com/path_to_image.jpg', // Replace with a valid image URL or asset
                            previousSales: [
                              {'product': 'طماطم', 'quantity': '10', 'date': '2024-12-01'},
                              {'product': 'بطاطا', 'quantity': '5', 'date': '2024-11-28'},
                              {'product': 'بصل', 'quantity': '15', 'date': '2024-11-25'},
                              // You can add or modify previous sales data as needed
                            ],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      color: const Color.fromARGB(136, 255, 255, 255),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                          child: Text(
                            filteredMarketSellers[index]['name']![0],
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        title: Text(
                          filteredMarketSellers[index]['name']!,
                          style: const TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 16,
                            color: Color.fromARGB(255, 15, 75, 6),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('المنتج: ${filteredMarketSellers[index]['product']}'),
                            Text('الموقع: ${filteredMarketSellers[index]['location']}'),
                            Text('التقييم: ${filteredMarketSellers[index]['rating']}'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 15, 75, 6)),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Past customers section
            Text(
              'العملاء السابقين',
              style: const TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 15, 75, 6),
              ),
            ),
            const SizedBox(height: 10),
            // Past customer list
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pastCustomers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerProfilePage(
                            sellerName: pastCustomers[index]['name']!, // Use the customer's name
                            sellerLocation: 'موقع العميل', // You can add a generic location or customer-specific data if available
                            sellerRating: 'غير متاح', // You can set a placeholder or leave it empty for customers
                            profileImage: pastCustomers[index]['image']!, // Image from the pastCustomers list
                            previousSales: [
                              {'product': 'طماطم', 'quantity': '10', 'date': '2024-12-01'},
                              {'product': 'بطاطا', 'quantity': '5', 'date': '2024-11-28'},
                              {'product': 'بصل', 'quantity': '15', 'date': '2024-11-25'},
                              // You can add or modify previous sales data as needed
                            ],
                          ),
                        ),
                      );


                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(144, 255, 255, 255),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(pastCustomers[index]['image']!),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pastCustomers[index]['name']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed'),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pastCustomers[index]['purchase']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
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



// Placeholder for the Customer Profile Page
class CustomerProfilePage extends StatelessWidget {
  final String customerName;
  const CustomerProfilePage({super.key, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$customerName - بروفايل العميل'),
      ),
      body: Center(
        child: Text('تفاصيل بروفايل $customerName'),
      ),
    );
  }
}
