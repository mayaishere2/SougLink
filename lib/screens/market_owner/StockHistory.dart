import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StockHistoryPage extends StatefulWidget {
  final String selectedItem;
  final VoidCallback onClose;

  StockHistoryPage({required this.selectedItem, required this.onClose});

  @override
  State<StockHistoryPage> createState() => _StockHistoryPageState();
}

class _StockHistoryPageState extends State<StockHistoryPage> {
  Map<String, int> stockLevels = {};
  List<Map<String, String>> history = [];
  final TextEditingController itemController = TextEditingController();
  String? currentSelectedItem;

  @override
  void initState() {
    super.initState();
    currentSelectedItem = widget.selectedItem;
    fetchProductsFromFirestore();
  }

  void fetchProductsFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser; // Get current user

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يجب عليك تسجيل الدخول أولاً!')),
      );
      return;
    }

    String userId = user.uid; // Use UID to get user's products

    FirebaseFirestore.instance
        .collection('users') // Use 'users' collection
        .doc(userId)
        .collection('products') // Fetch from user's 'products' subcollection
        .get()
        .then((querySnapshot) {
      setState(() {
        stockLevels.clear();
        for (var doc in querySnapshot.docs) {
          String title = doc['name'];
          int amount = (doc['amount'] as num?)?.toInt() ?? 0;
          stockLevels[title] = amount;
        }
      });
    });
  }

  Stream<String> getDetailsStream(String? item, String wanted) {
    if (item == null || item.isEmpty) {
      print("DEBUG: No item selected");
      return Stream.value('Unknown');
    }

    User? user = FirebaseAuth.instance.currentUser; // Get current user

    if (user == null) {
      print("DEBUG: User not logged in");
      return Stream.value('Unknown');
    }

    String userId = user.uid; // Get user ID

    return FirebaseFirestore.instance
        .collection('users') // Updated Firestore path
        .doc(userId)
        .collection('products') // Fetch from user's products subcollection
        .where('name', isEqualTo: item.trim()) // Find the product by name
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        print("DEBUG: Document $item does not exist in Firestore");
        return 'Unknown';
      }

      var doc = querySnapshot.docs.first; // Get the first matching document
      var data = doc.data();
      print("DEBUG: Data from Firestore for $item: $data");

      if (wanted == 'name') {
        return data['name'] ?? 'Unknown';
      }

      if (wanted == 'amount') {
        int amount = (data['amount'] as num?)?.toInt() ?? 0;
        return amount.toString();
      }

      if (wanted == 'status') {
        int currentStock = (data['amount'] as num?)?.toInt() ?? 0;
        if (currentStock <= 0) return 'نفاد المخزون';
        if (currentStock < 40) return 'منخفضة';
        return 'كافية';
      }

      if (wanted == 'image') {
        return data['image'] ?? 'assets/images/default.png';
      }

      return 'Unknown';
    });
  }

  void _addStock(int amount) async {
    if (currentSelectedItem == null || currentSelectedItem!.isEmpty) return;

    User? user = FirebaseAuth.instance.currentUser; // Get current user
    if (user == null) return;

    String userId = user.uid; // Get user ID

    // Reference to the user's specific product document
    QuerySnapshot productQuery = await FirebaseFirestore.instance
        .collection('users') // Updated Firestore path
        .doc(userId)
        .collection('products') // Fetch from user's products subcollection
        .where('name', isEqualTo: currentSelectedItem)
        .get();

    if (productQuery.docs.isEmpty) return; // No matching product found

    DocumentReference productRef = productQuery.docs.first.reference;

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot productDoc = await transaction.get(productRef);
      if (!productDoc.exists) return;

      int currentAmount = (productDoc['amount'] as num?)?.toInt() ?? 0;
      int newAmount =
          (currentAmount + amount).clamp(0, double.infinity).toInt();

      transaction.update(productRef, {'amount': newAmount});

      _addToHistory('تمت إضافة $amount كج', 'add');
    });
  }

  void _removeStock(int amount) async {
    if (currentSelectedItem == null || currentSelectedItem!.isEmpty) return;

    User? user = FirebaseAuth.instance.currentUser; // Get current user
    if (user == null) return;

    String userId = user.uid; // Get user ID

    // Reference to the user's specific product document
    QuerySnapshot productQuery = await FirebaseFirestore.instance
        .collection('users') // Updated Firestore path
        .doc(userId)
        .collection('products') // Fetch from user's products subcollection
        .where('name', isEqualTo: currentSelectedItem)
        .get();

    if (productQuery.docs.isEmpty) return; // No matching product found

    DocumentReference productRef = productQuery.docs.first.reference;

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot productDoc = await transaction.get(productRef);
      if (!productDoc.exists) return;

      int currentAmount = (productDoc['amount'] as num?)?.toInt() ?? 0;
      int newAmount =
          (currentAmount - amount).clamp(0, double.infinity).toInt();

      transaction.update(productRef, {'amount': newAmount});

      if (newAmount <= 0) {
        _addToHistory('نفاد المخزون', 'empty');
      } else {
        _addToHistory('تم استهلاك $amount كج', 'remove');
      }
    });
  }

  Stream<Map<String, int>> getStockStream() {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user == null) {
      return Stream.value({}); // Return an empty map if no user is logged in
    }

    String userId = user.uid; // Get user ID

    return FirebaseFirestore.instance
        .collection('users') // Updated Firestore path
        .doc(userId)
        .collection('products') // Fetch from user's products subcollection
        .snapshots()
        .map((snapshot) {
      Map<String, int> updatedStockLevels = {};
      for (var doc in snapshot.docs) {
        updatedStockLevels[doc['name']] = (doc['amount'] as num?)?.toInt() ?? 0;
      }
      return updatedStockLevels;
    });
  }

  void _addToHistory(String action, String type) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User not logged in.");
      return;
    }

    String userId = user.uid;

    if (currentSelectedItem == null || currentSelectedItem!.isEmpty) {
      print("No selected item found.");
      return;
    }

    // Fetch product name based on Firestore structure
    String productName = await _fetchProductName(userId, currentSelectedItem!);

    if (productName.isEmpty) {
      print("Product name not found for: $currentSelectedItem");
      return;
    }

    if (!mounted) return; // Ensure widget is still in the tree

    String nowDate = DateTime.now().toLocal().toString().split(' ')[0];
    TimeOfDay nowTime = TimeOfDay.fromDateTime(DateTime.now());
    String formattedTime = "${nowTime.hour}:${nowTime.minute}";

    String imageAdd = 'assets/images/add.png';
    String imageRemove = 'assets/images/remove.png';

    setState(() {
      history.insert(0, {
        'item': productName,
        'action': action,
        'date': nowDate,
        'time': formattedTime,
        'type': type,
        'image': type == 'add' ? imageAdd : imageRemove,
      });

      print("History Updated. Current Length: ${history.length}");
    });
  }

  Future<String> _fetchProductName(String userId, String productId) async {
    try {
      // Correct Firestore path
      CollectionReference productsRef = FirebaseFirestore.instance
          .collection('users') // Corrected collection name
          .doc(userId)
          .collection('products');

      QuerySnapshot querySnapshot =
          await productsRef.where('name', isEqualTo: productId).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['name'] ?? '';
      }
      print("Product not found in Firestore.");
    } catch (e) {
      print("Error fetching product name: $e");
    }
    return ''; // Return empty if product not found or error occurs
  }

  List<FlSpot> _generateLineChartData() {
    List<FlSpot> spots = [];
    for (int i = 0; i < history.length; i++) {
      final entry = history[i];
      double x = i.toDouble();
      double y = 0;

      // Try to extract the numerical value from the action text
      String action = entry['action'] ?? '';
      if (action.contains('تمت إضافة')) {
        y = -double.tryParse(action.split(' ')[2])! ??
            0; // Extract the amount added
      } else if (action.contains('تم استهلاك')) {
        y = double.tryParse(action.split(' ')[2]) ??
            0; // Extract the amount removed
      } else if (action == 'نفاد المخزون') {
        y = 0; // Set Y to 0 when stock is out
      }

      spots.add(FlSpot(x, y));
    }
    return spots.reversed.toList(); // Reverse to show most recent data first
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, int>>(
      stream: getStockStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          stockLevels = snapshot.data!;
        }
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(240, 15, 75, 6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StreamBuilder<String>(
                        stream: getDetailsStream(currentSelectedItem, 'name'),
                        builder: (context, snapshot) {
                          return Text(
                            ' المنتج:                  ${snapshot.data} ',
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onClose,
                      icon: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    StreamBuilder<String>(
                      stream: getDetailsStream(currentSelectedItem, 'image'),
                      builder: (context, snapshot) {
                        return Container(
                          width: 120,
                          height: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(snapshot.data ??
                                  'assets/images/default_image.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 25),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<String>(
                            stream:
                                getDetailsStream(currentSelectedItem, 'amount'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  'جاري التحميل...',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'خطأ في جلب البيانات',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                );
                              }
                              return Text(
                                'الكمية المتوفرة حاليًا: ${snapshot.data ?? "غير معروف"}',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          StreamBuilder<String>(
                            stream:
                                getDetailsStream(currentSelectedItem, 'status'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  'جاري التحميل...',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'خطأ في جلب البيانات',
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                );
                              }
                              return Text(
                                'حالة المخزون: ${snapshot.data ?? "غير معروف"}',
                                style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  // Using the index or some other logic to display time or index
                                  return Text('$value');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text('$value');
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                              show: true,
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          minX: 0,
                          maxX: history.length > 0 ? history.length - 1 : 0,
                          minY: 0,
                          maxY: history.isNotEmpty
                              ? history.map((e) {
                                  return double.tryParse(
                                          e['action']?.split(' ')[1] ?? '0') ??
                                      0;
                                }).reduce((a, b) => a > b ? a : b)
                              : 0,
                          lineBarsData: [
                            LineChartBarData(
                              spots: _generateLineChartData(),
                              isCurved: true,
                              color: Colors.white,
                              barWidth: 4,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 20),
                Text(
                  'تاريخ الاستهلاك:',
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 20),
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 243, 226),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (context, index) {
                                  final entry = history[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          '${entry['image']}',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Flexible(
                                          child: Text(
                                            ' ${entry['action']}      ${entry['time']!}, ${entry['date']!}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Kanit',
                                              fontSize: 14,
                                            ),
                                            textDirection: TextDirection.rtl,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        int amount = int.tryParse(itemController.text) ?? 10;
                        _addStock(amount);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 228, 243, 226),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child:
                          const Icon(Icons.add, size: 20, color: Colors.green),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: itemController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        int amount = int.tryParse(itemController.text) ?? 10;
                        _removeStock(amount);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 228, 243, 226),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child:
                          const Icon(Icons.remove, size: 20, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment(-1, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Color.fromRGBO(250, 199, 30, 1),
                      child: Text(
                        'البحث عن مزارع ',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
