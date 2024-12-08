import 'package:flutter/material.dart';

class HarvestInfoPage extends StatefulWidget {
  final Map<String, String> product; // Add product parameter

  const HarvestInfoPage({Key? key, required this.product}) : super(key: key);

  @override
  State<HarvestInfoPage> createState() => _HarvestInfoPageState();
}

class _HarvestInfoPageState extends State<HarvestInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> harvestData = [
    {'date': '2024-11-01', 'quantity': '500 كجم', 'notes': 'جودة ممتازة', 'location': 'الحقل 1'},
    {'date': '2024-11-10', 'quantity': '300 كجم', 'notes': 'جودة متوسطة', 'location': 'الحقل 2'},
    {'date': '2024-11-15', 'quantity': '200 كجم', 'notes': 'جودة ضعيفة', 'location': 'الحقل 3'},
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  void _showAddRecordForm() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              'إضافة سجل محصول جديد',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'NotoSansArabic_SemiCondensed',
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'التاريخ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'الكمية',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: 'الملاحظات/الجودة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'الحقل/الموقع',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_dateController.text.isNotEmpty &&
                      _quantityController.text.isNotEmpty &&
                      _notesController.text.isNotEmpty &&
                      _locationController.text.isNotEmpty) {
                    setState(() {
                      harvestData.add({
                        'date': _dateController.text,
                        'quantity': _quantityController.text,
                        'notes': _notesController.text,
                        'location': _locationController.text,
                      });
                    });
                    Navigator.pop(context); // Close the dialog
                  }
                },
                child: Text(
                  'إضافة',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansArabic_SemiCondensed',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFE4F3E2),
        body: Stack(
          children: [
            Column(
              children: [
                // Top Section
                SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'تتبع محصول',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSansArabic_SemiCondensed',
                            ),
                          ),
                        ),
                        Text(
                          widget.product['name'] ?? '',
                          style: TextStyle(
                            color: const Color.fromARGB(191, 15, 75, 6),
                            fontSize: 22,
                            fontFamily: 'NotoSansArabic_SemiCondensed',
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 82,
                      backgroundColor: Colors.white,
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 0.7,
                        child: Image.asset(widget.product['image'] ?? ''),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                // Total Harvest Section
                _infoBox('إجمالي المحصول', '2000 كجم هذا الموسم'),
                SizedBox(height: 10),
                _infoBox('آخر تحديث', '15 نوفمبر 2024'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _showAddRecordForm,
                  child: Text(
                    'إضافة سجل محصول',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSansArabic_SemiCondensed',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 15, 75, 6),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: harvestData.length,
                    itemBuilder: (context, index) {
                      return _harvestCard(harvestData[index]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      height: 48,
      width: 347,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 15, 75, 6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NotoSansArabic_SemiCondensed',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color.fromARGB(255, 15, 75, 6),
              fontFamily: 'NotoSansArabic_SemiCondensed',
            ),
          ),
        ],
      ),
    );
  }

  Widget _harvestCard(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 15, 75, 6),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 15, 75, 6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text('التاريخ', style: TextStyle(color: Colors.white, fontFamily: 'NotoSansArabic_SemiCondensed')),
                SizedBox(height: 8),
                Text(data['date']!, style: TextStyle(color: Colors.white , fontFamily: 'NotoSansArabic_SemiCondensed')),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الكمية: ${data['quantity']}', style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NotoSansArabic_SemiCondensed',
                                        ),),
                  SizedBox(height: 5,),
                  Text('الملاحظات/الجودة: ${data['notes']}', style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NotoSansArabic_SemiCondensed',
                                        ),),
                  SizedBox(height: 5,),
                  Text('الحقل/الموقع: ${data['location']}', style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NotoSansArabic_SemiCondensed',
                                        ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
