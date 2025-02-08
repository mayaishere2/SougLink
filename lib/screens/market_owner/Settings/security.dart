import 'package:flutter/material.dart';
import 'colors.dart';
import 'changePass.dart';
import 'loginActivity.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'الأمان',
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
                'إدارة إعدادات الأمان الخاصة بك:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 20),
              _buildSecurityOption(
                icon: Icons.lock_outline,
                title: 'تغيير كلمة المرور',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                  );
                },
              ),
              Divider(color: thirdBlack, thickness: 1),
              _buildSecurityOption(
                icon: Icons.security,
                title: 'تمكين المصادقة الثنائية',
                trailing: Switch(
                  value: _isTwoFactorEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isTwoFactorEnabled = value;
                    });
                  },
                  activeColor: mainGreen,
                  inactiveThumbColor: thirdBlack,
                  inactiveTrackColor: secondBlack,
                ),
              ),
              Divider(color: thirdBlack, thickness: 1),
              _buildSecurityOption(
                icon: Icons.history,
                title: 'عرض نشاط تسجيل الدخول',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginActivityPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: mainGreen),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18,
          ),
      onTap: onTap,
    );
  }
}
