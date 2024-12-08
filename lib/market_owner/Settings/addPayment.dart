import 'package:flutter/material.dart';
import 'colors.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({Key? key}) : super(key: key);

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'إضافة وسيلة الدفع',
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
        textDirection: TextDirection.rtl, // Set the text direction to right-to-left
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text and input fields to the right
            children: [
              const Text(
                'أدخل تفاصيل بطاقة الدفع الخاصة بك:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('اسم حامل البطاقة', _cardHolderController, Icons.person),
              const SizedBox(height: 15),
              _buildTextField('رقم البطاقة (16 رقم)', _cardNumberController, Icons.credit_card),
              const SizedBox(height: 15),
              _buildTextField('تاريخ انتهاء البطاقة (MM/YY)', _expiryDateController, Icons.date_range),
              const SizedBox(height: 15),
              _buildTextField('رمز CVV (3 أرقام)', _cvvController, Icons.lock),
              const SizedBox(height: 20),
              _buildTextField('اسم البنك', _bankNameController, Icons.business),
              const SizedBox(height: 15),
              _buildTextField('رقم IBAN (رقم الحساب الدولي)', _ibanController, Icons.account_balance),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إضافة وسيلة الدفع!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 50,
                    ),
                  ),
                  child: const Text(
                    'إضافة وسيلة الدفع',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: inputHint),
        prefixIcon: Icon(icon, color: inputHint),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondBlack),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainGreen),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: secondBlack,
      ),
    );
  }
}
