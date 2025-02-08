import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellerProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String location;
  final String profileImage;
  final String sellerId;

  const SellerProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.location,
    required this.profileImage,
    required this.sellerId,
  });

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  double _currentRating = 3.0;

  void _submitRating() {
    FirebaseFirestore.instance.collection('ratings').add({
      'sellerId': widget.sellerId,
      'rating': _currentRating,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت إضافة التقييم بنجاح!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'بروفايل ${widget.firstName} ${widget.lastName}',
          style: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed'),
        ),
        backgroundColor: const Color(0xFFE4F3E2),
      ),
      
      backgroundColor: const Color(0xFFE4F3E2),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.firstName} ${widget.lastName}',
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
                        Text(widget.location),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.blueGrey),
                        const SizedBox(width: 5),
                        Text(widget.phoneNumber),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.profileImage),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'تقييم البائع',
              style: TextStyle(
                fontFamily: 'NotoSansArabic_SemiCondensed',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 15, 75, 6),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _currentRating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _currentRating.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentRating = value;
                      });
                    },
                  ),
                ),
                Text(_currentRating.toString()),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitRating,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 15, 75, 6),
              ),
              child: const Text('إضافة تقييم', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle contact action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('تواصل مع البائع', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}