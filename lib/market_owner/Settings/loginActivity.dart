import 'package:flutter/material.dart';
import 'colors.dart';

class LoginActivityPage extends StatelessWidget {
  const LoginActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> loginActivities = [
      {'date': '2024-12-01', 'location': 'الجزائر العاصمة, الجزائر', 'device': 'Chrome على Windows'},
      {'date': '2024-11-28', 'location': 'وهران, الجزائر', 'device': 'Safari على iPhone'},
      {'date': '2024-11-25', 'location': 'تلمسان, الجزائر', 'device': 'Firefox على Linux'},
    ];

    return Scaffold(
      backgroundColor: mainBlack,
      appBar: AppBar(
        title: const Text(
          'نشاط الدخول',
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
            itemCount: loginActivities.length,
            separatorBuilder: (context, index) => Divider(
              color: thirdBlack,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final activity = loginActivities[index];
              return ListTile(
                leading: Icon(Icons.access_time, color: mainGreen),
                title: Text(
                  activity['date']!,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                ),
                subtitle: Text(
                  '${activity['location']} • ${activity['device']}',
                  style: TextStyle(color: inputHint, fontFamily: 'Inter'),
                ),
                trailing: const Icon(Icons.more_vert, color: Colors.white),
                onTap: () {
                  _showActionModal(context, activity);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showActionModal(BuildContext context, Map<String, String> activity) {
    showModalBottomSheet(
      context: context,
      backgroundColor: secondBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'تفاصيل النشاط',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${activity['date']}',
                style: TextStyle(color: inputHint, fontFamily: 'Inter'),
              ),
              Text(
                '${activity['location']} • ${activity['device']}',
                style: TextStyle(color: inputHint, fontFamily: 'Inter'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم حظر النشاط!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'حظر',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم السماح بالنشاط!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'السماح',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
