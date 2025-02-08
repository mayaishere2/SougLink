import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HarvestInfoPage extends StatefulWidget {
  final Map<String, String> product;

  const HarvestInfoPage({Key? key, required this.product}) : super(key: key);

  @override
  State<HarvestInfoPage> createState() => _HarvestInfoPageState();
}

class _HarvestInfoPageState extends State<HarvestInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? "guest";
  CollectionReference get harvestCollection => FirebaseFirestore.instance
      .collection('harvest_records')
      .doc(userId)
      .collection(widget.product['name']!);

  void _addHarvestRecord() {
    if (_dateController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _notesController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {
      harvestCollection.add({
        'date': _dateController.text,
        'quantity': _quantityController.text,
        'notes': _notesController.text,
        'location': _locationController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    }
  }

  void _showAddRecordForm() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: AlertDialog(
              title: const Text('إضافة سجل محصول جديد',
                  style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', color: Colors.black)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(_dateController, 'التاريخ'),
                  _buildTextField(_quantityController, 'الكمية'),
                  _buildTextField(_notesController, 'الملاحظات/الجودة'),
                  _buildTextField(_locationController, 'الحقل/الموقع'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء',
                      style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: _addHarvestRecord,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 15, 75, 6)),
                  child: const Text('إضافة',
                      style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFE4F3E2),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('تتبع محصول',
                    style: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(widget.product['name']!,
                style: const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', fontSize: 22, color: Color.fromARGB(191, 15, 75, 6))),
            const SizedBox(height: 20),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    widget.product['image']!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 10,
              width: double.infinity,
              color: Color.fromARGB(255, 15, 75, 6), // Change this to your desired color
            )
            ,
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _showAddRecordForm,
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 15, 75, 6)),
              child: const Text('إضافة سجل محصول',
                  style: TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', color: Colors.white)),
            ),
            Expanded(
              child: StreamBuilder(
                stream: harvestCollection.orderBy('timestamp', descending: true).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('لا توجد سجلات بعد.'));
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((doc) => _harvestCard(doc)).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _harvestCard(QueryDocumentSnapshot doc) {
  var data = doc.data() as Map<String, dynamic>;
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color.fromARGB(255, 15, 75, 6), width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between text and delete button
        children: [
          Row(
            children: [
              // Right side - Labels inside a dark green container
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 15, 75, 6), // Dark green background
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _labelText('التاريخ:'),
                    _labelText('الكمية:'),
                    _labelText('الملاحظات:'),
                    _labelText('الموقع:'),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelText2('${data['date']}'),
                  _labelText2('${data['quantity']}'),
                  _labelText2('${data['notes']}'),
                  _labelText2('${data['location']}'),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteHarvestRecord(doc.id),
          ),
        ],
      ),
    ),
  );
}

void _deleteHarvestRecord(String docId) {
  harvestCollection.doc(docId).delete();
}

// Helper function to style the labels
Widget _labelText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
Widget _labelText2(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}

  TextStyle _textStyle() {
    return const TextStyle(fontFamily: 'NotoSansArabic_SemiCondensed', color: Colors.black);
  }
}
