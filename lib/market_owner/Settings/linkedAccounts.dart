import 'package:flutter/material.dart';
import 'colors.dart';

class LinkedAccountsPage extends StatelessWidget {
  const LinkedAccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> linkedAccounts = [
      {'platform': 'Google', 'email': 'karimsbaihi@gmail.com'},
      {'platform': 'Facebook', 'email': 'karim.fb@facebook.com'},
      {'platform': 'Twitter', 'email': 'karim_twtr@twitter.com'},
    ];

    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'الحسابات المرتبطة',
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
          child: ListView.separated(
            itemCount: linkedAccounts.length,
            separatorBuilder: (context, index) => Divider(
              color: thirdBlack,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final account = linkedAccounts[index];
              return ListTile(
                leading: Icon(Icons.link, color: mainGreen),
                title: Text(
                  account['platform']!,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                ),
                subtitle: Text(
                  account['email']!,
                  style: TextStyle(color: inputHint, fontFamily: 'Inter'),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () {
                    _showDisconnectDialog(context, account);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDisconnectDialog(BuildContext context, Map<String, String> account) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: secondBlack,
          title: Text(
            'فصل حساب ${account['platform']}',
            style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
          ),
          content: Text(
            'هل أنت متأكد أنك تريد فصل حسابك على ${account['platform']}؟',
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
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${account['platform']} حساب مفصول!'),
                  ),
                );
              },
              child: const Text(
                'فصل',
                style: TextStyle(color: Colors.red, fontFamily: 'Inter'),
              ),
            ),
          ],
        );
      },
    );
  }
}
