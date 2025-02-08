import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'farmerDrawer.dart';
import 'package:souglink/screens/farmer/SellerProfilePage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredMarketSellers = [];

  @override
  void initState() {
    super.initState();
    _fetchMarketSellers();
  }

  Future<void> _fetchMarketSellers() async {
  FirebaseFirestore.instance
      .collection('users')
      .where('userType', isEqualTo: 'بائع سوق')
      .get()
      .then((querySnapshot) {
    if (!mounted) return; // Prevent calling setState if widget is unmounted

    setState(() {
      filteredMarketSellers = querySnapshot.docs.map((doc) {
        var data = doc.data();
        return {
          'id': doc.id,
          'firstName': data['firstName'] ?? '',
          'lastName': data['lastName'] ?? '',
          'location': data['location'] ?? '',
          'phone': data['phone'] ?? data['phoneNumber'] ?? '',
          'profilePic': data['profilePic'] ?? '',
        };
      }).toList();
    });
  }).catchError((error) {
    if (!mounted) return;
    debugPrint("Error fetching sellers: $error");
  });
}


  void _filterSellers(String query) {
    setState(() {
      filteredMarketSellers = filteredMarketSellers.where((seller) =>
          seller['name'].contains(query) ||
          seller['location'].contains(query) ||
          seller['phone'].contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: the_Drawer(),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 60.0),
          child: Text('بحث عن بائعين السوق', style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed')),
        ),
        backgroundColor: const Color(0xFFE4F3E2),
      ),
      backgroundColor: const Color(0xFFE4F3E2),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Text(
              'نتائج البحث',
              style: TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 15, 75, 6),
              ),
            ),
            const SizedBox(height: 10),
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
                            firstName: filteredMarketSellers[index]['firstName'],
                            lastName: filteredMarketSellers[index]['lastName'],
                            phoneNumber: filteredMarketSellers[index]['phone'],
                            location: filteredMarketSellers[index]['location'],
                            profileImage: filteredMarketSellers[index]['profilePic'],
                            sellerId: filteredMarketSellers[index]['id'], // Ensure you have this field
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
                          backgroundImage: NetworkImage(filteredMarketSellers[index]['profilePic']),
                        ),
                        title: Text(
                          "${filteredMarketSellers[index]['firstName']} ${filteredMarketSellers[index]['lastName']}",
                          style: const TextStyle(
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                            fontSize: 16,
                            color: Color.fromARGB(255, 15, 75, 6),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('الموقع: ${filteredMarketSellers[index]['location']}'),
                            Text('رقم الهاتف: ${filteredMarketSellers[index]['phone']}'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 15, 75, 6)),
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