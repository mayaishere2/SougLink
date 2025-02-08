import 'package:flutter/material.dart';
import 'colors.dart';
import 'addPayment.dart';
import 'payHistory.dart';
import 'removePayment.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'الدفع',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'إدارة طرق الدفع الخاصة بك:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 20),
              _buildPaymentOption(
                icon: Icons.credit_card,
                title: 'إضافة وسيلة دفع',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPaymentPage()),
                  );
                },
              ),
              Divider(color: thirdBlack, thickness: 1),
              _buildPaymentOption(
                icon: Icons.payment,
                title: 'سجل الدفع',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PayHistoryPage()),
                  );
                },
              ),
              Divider(color: thirdBlack, thickness: 1),
              _buildPaymentOption(
                icon: Icons.remove_circle,
                title: 'إزالة وسيلة دفع',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RemovePaymentPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: mainGreen),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}
