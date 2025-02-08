import 'package:flutter/material.dart';
import 'colors.dart';

class PayHistoryPage extends StatelessWidget {
  PayHistoryPage({Key? key}) : super(key: key);

  final List<Map<String, String>> paymentHistory = [
    {
      'date': '2024-12-01',
      'amount': '500.00 د.ج',
      'status': 'تم',
    },
    {
      'date': '2024-11-25',
      'amount': '300.00 د.ج',
      'status': 'قيد الانتظار',
    },
    {
      'date': '2024-11-18',
      'amount': '750.00 د.ج',
      'status': 'فشل',
    },
    {
      'date': '2024-11-10',
      'amount': '1200.00 د.ج',
      'status': 'تم',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'تاريخ الدفع',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
        centerTitle: true,
        backgroundColor: mainBlack,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white), // Back icon pointing right
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // Set text direction to right-to-left
        child: ListView.builder(
          itemCount: paymentHistory.length,
          itemBuilder: (context, index) {
            final payment = paymentHistory[index];
            return Card(
              color: secondBlack,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: Icon(Icons.payment, color: mainGreen),
                title: Text(
                  'المبلغ: ${payment['amount']}',
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Inter', fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'التاريخ: ${payment['date']}',
                      style: TextStyle(
                          color: inputHint, fontFamily: 'Inter', fontSize: 14),
                    ),
                    Text(
                      'الحالة: ${payment['status']}',
                      style: TextStyle(
                          color: payment['status'] == 'تم'
                              ? Colors.green
                              : payment['status'] == 'قيد الانتظار'
                                  ? Colors.orange
                                  : Colors.red,
                          fontFamily: 'Inter',
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
