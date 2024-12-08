import 'package:flutter/material.dart';
import 'colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'تغيير كلمة المرور',
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
                'تحديث كلمة المرور الخاصة بك:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 20),
              _buildPasswordField('كلمة المرور الحالية', _currentPasswordController),
              const SizedBox(height: 15),
              _buildPasswordField('كلمة المرور الجديدة', _newPasswordController),
              const SizedBox(height: 15),
              _buildPasswordField('تأكيد كلمة المرور', _confirmPasswordController),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_newPasswordController.text == _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم تحديث كلمة المرور بنجاح!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('كلمات المرور غير متطابقة!'),
                        ),
                      );
                    }
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
                    'حفظ التغييرات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
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

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: inputHint, fontFamily: 'Inter'),
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
