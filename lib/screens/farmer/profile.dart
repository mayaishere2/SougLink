import 'package:flutter/material.dart';
import 'package:souglink/screens/login_signup/login_page.dart';
import 'package:souglink/screens/farmer/mainPageFarmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class CloudinaryService {
  final String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? "";
  final String uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? "";

  Future<String?> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    File file = File(image.path);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
      );

      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['upload_preset'] = uploadPreset;

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      if (response.statusCode == 200) {
        String imageUrl = jsonResponse['secure_url'];
        return imageUrl;
      } else {
        print("Upload failed: ${jsonResponse['error']['message']}");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}
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
  void initState() {
    super.initState();
    fetchUserData();
  }
void fetchUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (userDoc.exists && mounted) { // Check if mounted before calling setState
      setState(() {
        String firstName = userDoc['firstName'] ?? '';
        String lastName = userDoc['lastName'] ?? '';
        userName = "$firstName $lastName";
        location = userDoc['location'] ?? 'الموقع غير محدد';
        phoneNumber = userDoc['phoneNumber'] ?? '+213 000000000';
        profilePic = userDoc['profilePic'] ?? 'assets/images/profile.jpg';
      });
    }
  }
}
 Future<void> uploadProfilePicture() async {
  CloudinaryService cloudinaryService = CloudinaryService();
  String? imageUrl = await cloudinaryService.uploadImage();

  if (imageUrl != null) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profilePic': imageUrl,
      });

      setState(() {
        profilePic = imageUrl;
      });

      print("Profile picture updated: $imageUrl");
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isEditing ? Colors.white : const Color.fromARGB(255, 14, 78, 5),
      body: isEditing ? buildEditProfile() : buildProfileView(),
    );
  }

  Widget buildProfileView() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.height * 0.18,
            MediaQuery.of(context).size.width * 0.05,
            0,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(213, 255, 255, 255),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(phoneNumber, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              Text(location, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 14, 78, 5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("تعديل الملف الشخصي", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              ...PRF.map((item) => Createcard(item['title'], item['image'], context, PRF.indexOf(item) + 1)).toList(),
            ],
          ),
        ),
        Positioned(
  top: MediaQuery.of(context).size.height * 0.12,
  left: (MediaQuery.of(context).size.width - 100) / 2,
  child: GestureDetector(
    onTap: uploadProfilePicture,
    child: Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profilePic.startsWith('http') 
              ? NetworkImage(profilePic) 
              : FileImage(File(profilePic)) as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(Icons.camera_alt, color: Colors.black),
          ),
        ),
      ],
    ),
  ),
),

      ],
    );
  }




  Widget buildEditProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: profilePic.startsWith('http')
                  ? NetworkImage(profilePic + "?t=${DateTime.now().millisecondsSinceEpoch}") // Add timestamp to force reload
                  : FileImage(File(profilePic)) as ImageProvider,
            ),

            const SizedBox(height: 20),
            TextField(
              controller: userNameController..text = userName,
              decoration: const InputDecoration(labelText: 'اسم المستخدم', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: locationController..text = location,
              decoration: const InputDecoration(labelText: 'الموقع', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneNumberController..text = phoneNumber,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'رقم الهاتف', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    List<String> nameParts = userNameController.text.split(' ');
                    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
                    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

                    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                      'firstName': firstName,
                      'lastName': lastName,
                      'location': locationController.text,
                      'phoneNumber': phoneNumberController.text,
                      'profilePic': profilePic,
                    });

                    setState(() {
                      userName = "$firstName $lastName";
                      location = locationController.text;
                      phoneNumber = phoneNumberController.text;
                      isEditing = false;
                    });
                  }
                },
                child: const Text("حفظ التعديلات", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 14, 78, 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
