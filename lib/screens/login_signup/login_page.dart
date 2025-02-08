import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souglink/bloc/login_cubit.dart';
import 'package:souglink/screens/market_owner/MainPageSeller.dart';
import 'package:souglink/screens/farmer/MainPageFarmer.dart';
import 'package:souglink/screens/login_signup/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  Color _usernameFillColor = const Color.fromARGB(107, 255, 255, 255);
  Color _passwordFillColor = const Color.fromARGB(107, 255, 255, 255);
  bool _isVisible = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {
        _usernameFillColor = _usernameFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordFillColor = _passwordFocusNode.hasFocus
            ? const Color.fromARGB(0, 255, 255, 255)
            : const Color.fromARGB(107, 255, 255, 255);
      });
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (userDoc.exists) {
        String userType = userDoc['userType'];
        if (userType == 'مزارع') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPageFarmer(activeIndex: 4)),
          );
        } else if (userType == 'بائع سوق') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPageSeller(activeIndex: 4)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data not found.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 66, 4),
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
          Align(
            alignment: Alignment(0, -0.75),
            child: Container(
              width: 122,
              height: 122,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset('assets/logo.png'),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            bottom: _isVisible ? 0 : -520,
            right: _isVisible ? 0 : -357,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: 357,
                height: 520,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 66, 4),
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(71)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'مرحباً',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      style: const TextStyle(color: Color(0xFFBBB9B9)),
                      decoration: InputDecoration(
                        hintText: 'البريد الإلكتروني',
                        prefixIcon: Icon(Icons.person, color: Color(0xFFBBB9B9)),
                        filled: true,
                        fillColor: _usernameFillColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Color(0xFFBBB9B9)),
                      decoration: InputDecoration(
                        hintText: 'كلمة السر',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFFBBB9B9)),
                        filled: true,
                        fillColor: _passwordFillColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 71, 118, 0),
                        fixedSize: const Size(310, 50),
                      ),
                      child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      child: const Text('ليس لديك حساب؟', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
