import 'package:flutter/material.dart';
import 'colors.dart';

class RemovePaymentPage extends StatelessWidget {
  RemovePaymentPage({Key? key}) : super(key: key);

  final List<Map<String, String>> paymentMethods = [
    {'cardType': 'Visa', 'lastFour': '1234'},
    {'cardType': 'MasterCard', 'lastFour': '5678'},
    {'cardType': 'Eddahabia', 'lastFour': '9876'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'إزالة وسيلة دفع',
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
        child: ListView.separated(
          itemCount: paymentMethods.length,
          separatorBuilder: (context, index) => Divider(color: thirdBlack),
          itemBuilder: (context, index) {
            final method = paymentMethods[index];
            return ListTile(
              leading: Icon(Icons.credit_card, color: mainGreen),
              title: Text(
                '${method['cardType']} •••• ${method['lastFour']}',
                style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _showRemoveDialog(context, method);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, Map<String, String> method) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: secondBlack,
          title: Text(
            'إزالة ${method['cardType']} المنتهية بـ ${method['lastFour']}؟',
            style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
          ),
          content: Text(
            'هل أنت متأكد من أنك تريد إزالة وسيلة الدفع هذه؟',
            style: TextStyle(color: inputHint, fontFamily: 'Inter'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'إلغاء',
                style: TextStyle(color: mainGreen, fontFamily: 'Inter'),
              ),
            ),
            TextButton(
              onPressed: () {
                // Remove payment method logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${method['cardType']} المنتهية بـ ${method['lastFour']} تمت إزالتها!'),
                  ),
                );
              },
              child: const Text(
                'إزالة',
                style: TextStyle(color: Colors.red, fontFamily: 'Inter'),
              ),
            ),
          ],
        );
      },
    );
  }
}
