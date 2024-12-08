import 'package:flutter/material.dart';
import 'package:souglink/market_owner/MainPageSeller.dart';
import 'package:souglink/farmer/MainPageFarmer.dart';
import 'package:souglink/login_signup/signup_page.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _LoginState();
}

class _LoginState extends State<Login_page> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  Color _usernameFillColor = const Color.fromARGB(107, 255, 255, 255);
  Color _passwordFillColor = const Color.fromARGB(107, 255, 255, 255);
  bool _isVisibile = false;

  // Dummy Data for login
  final Map<String, String> farmerCredentials = {
    'username': 'farmer1',
    'password': 'farmerpassword',
    'role': 'farmer',  // This represents the role
  };

  final Map<String, String> sellerCredentials = {
    'username': 'seller1',
    'password': 'sellerpassword',
    'role': 'seller',  // This represents the role
  };

  // Controllers for the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisibile = true;
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

  void _login(String username, String password) {
    // Check if the entered credentials match the farmer or seller
    if (username == farmerCredentials['username'] &&
        password == farmerCredentials['password']) {
      // Navigate to MainPageFarmer with activeIndex: 4
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageFarmer(activeIndex: 4),
        ),
      );
    } else if (username == sellerCredentials['username'] &&
        password == sellerCredentials['password']) {
      // Navigate to MainPageSeller with activeIndex: 4
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageSeller(activeIndex: 4),
        ),
      );
    } else {
      // Invalid credentials, show an alert
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 66, 4),
      body: Stack(
        children: [
          // Background Image
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
          // Logo in the center
          Align(
            alignment: Alignment(0, -0.75),
            child: Container(
              width: 122,
              height: 122,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
            ),
          ),
          // Login container at the bottom right
          AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeOut,
            bottom: _isVisibile ? 0 : -520,
            right: _isVisibile ? 0 : -357,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: 357,
                height: 520,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 66, 4),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(71)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Welcome Text
                    Text(
                      'مرحباً',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    // Username/Email Input
                    Container(
                      height: 50,
                      width: 310,
                      child: TextField(
                        controller: _usernameController,  // Use controller here
                        style: TextStyle(color: Color(0xFFBBB9B9)),
                        focusNode: _usernameFocusNode,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                          hintText: 'اسم المستخدم، البريد الإلكتروني، أو رقم الهاتف',
                          hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.person, color: Color(0xFFBBB9B9)),
                          ),
                          filled: true,
                          fillColor: _usernameFillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password Input
                    Container(
                      height: 50,
                      width: 310,
                      child: TextField(
                        controller: _passwordController,  // Use controller here
                        style: TextStyle(color: Color(0xFFBBB9B9)),
                        focusNode: _passwordFocusNode,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 19),
                          hintText: 'كلمة السر',
                          hintStyle: TextStyle(color: Color(0xFFBBB9B9)),
                          prefixIcon: Icon(Icons.lock, color: Color(0xFFBBB9B9)),
                          suffixIcon: Icon(Icons.visibility, color: Color(0xFFBBB9B9)),
                          filled: true,
                          fillColor: _passwordFillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color.fromARGB(255, 71, 118, 0), width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'هل نسيت كلمة المرور؟',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Login Button
                    SizedBox(
                      height: 43,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          String username = _usernameController.text;  // Get the username from the input field
                          String password = _passwordController.text;  // Get the password from the input field
                          _login(username, password);  // Pass them to the login function
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 71, 118, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          'تسجيل',
                          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟ ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                          },
                          child: Text(
                            'سجل الآن',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
