import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  
  final _formKey = GlobalKey<FormState>();
  final _userfirstnameController = TextEditingController();
  final _userlastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  String? selectedUserType;
  bool _isVisibile = false;

  // Signup process
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'firstName': _userfirstnameController.text,
          'lastName': _userlastnameController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneController.text,
          'userType': selectedUserType,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account Created Successfully')),
        );

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign Up Failed: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisibile = true;
      });
    });
  }

  @override
  void dispose() {
    _userfirstnameController.dispose();
    _userlastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 66, 4),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroundlogin.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeOut,
            top: _isVisibile ? 0 : -750,
            left: _isVisibile ? 0 : -357,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: 357,
                height: 750,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 12, 66, 4),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(71)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('التسجيل', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            icon: Icon(Icons.arrow_forward_sharp, color: Colors.white),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _userfirstnameController,
                        decoration: InputDecoration(
                          hintText: 'الاسم الأول',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter your first name' : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _userlastnameController,
                        decoration: InputDecoration(
                          hintText: 'اسم العائلة',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter your last name' : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'البريد الإلكتروني',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'رقم الهاتف',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: selectedUserType,
                        decoration: InputDecoration(
                          hintText: 'نوع المستخدم',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: ['مزارع', 'بائع سوق'].map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUserType = newValue;
                          });
                        },
                        validator: (value) => value == null ? 'Please select a user type' : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'كلمة المرور',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'تأكيد كلمة المرور',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signUp,
                        child: Text('تسجيل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 71, 118, 0),
                          minimumSize: Size(310, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
