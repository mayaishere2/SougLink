import 'package:flutter/material.dart';
import 'package:souglink/screens/login_signup/login_page.dart';
import 'package:souglink/screens/farmer/mainPageFarmer.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = 'اسم المستخدم';
  String location =
      'الموقع الجزائر العاصمة، زرالدة، المدينة الجديدة سيدي عبدالله';
  String phoneNumber = '+213 654901200';
  String profilePic = 'assets/images/profile.jpg';

  bool isEditing = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final List<Map<String, dynamic>> PRF = [
    {'title': ' المحاصيل', 'image': 'assets/images/stock.png'},
    {'title': 'الطلبات', 'image': 'assets/images/response.png'},
    {'title': 'تسجيل الخروج', 'image': 'assets/images/logout.png'},
  ];

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 78, 5),
          title: const Text(
            "تعديل الملف الشخصي",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(profilePic),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 24,
                        ),
                        onPressed: () {
                          //upload new profile pic
                          setState(() {
                            profilePic = 'assets/images/new_profile.jpg';
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: userNameController..text = userName,
                  decoration: const InputDecoration(
                    labelText: 'اسم المستخدم',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: locationController..text = location,
                  decoration: const InputDecoration(
                    labelText: 'الموقع',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneNumberController..text = phoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'رقم الهاتف',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          userName = userNameController.text;
                          location = locationController.text;
                          phoneNumber = phoneNumberController.text;
                          isEditing = false;
                        },
                      );
                    },
                    child: const Text(
                      "حفظ التعديلات",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      List<Widget> cards = [];
for (int i = 0; i < PRF.length; ++i) {
  cards.add(Createcard(PRF[i]['title'], PRF[i]['image'], context, i+1));
}

      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 14, 78, 5),
        
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.18,
                  MediaQuery.of(context).size.width * 0.05,
                  0,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(213, 255, 255, 255),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          child: Flexible(
                            child: Text(
                              userName,
                              style: const TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.black,
                              size: 19,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Flexible(
                                  child: Text(
                                    location,
                                    style: const TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.black,
                              size: 19,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Flexible(
                                  child: Text(
                                    phoneNumber,
                                    style: const TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          child: const Text(
                            "تعديل الملف الشخصي",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Kanit',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 14, 78, 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 14, 78, 5),
                                width: 3,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 14, 78, 5)
                                    .withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ...cards,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              left: (MediaQuery.of(context).size.width - 100) / 2,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(profilePic),
              ),
            ),
          ],
        ),
      );
    }
  }

Widget Createcard(String title, String pic, BuildContext context, int index) {
  if (index == 0){
    index =1;
  }
  if (index == 2) {
    index = 3;
  }
  return GestureDetector(
    onTap: () {
      if(index == 3){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Updated to use LoginPage
        ),
      );
  }
  else{
      // Navigate to MainPageSeller and pass the selected index
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageFarmer(
            activeIndex: index, // Pass the selected index
          ),
        ),
      );
    }},
    child: Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 14, 78, 5),
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              pic,
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
