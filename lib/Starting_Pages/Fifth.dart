import 'package:flutter/material.dart';
import 'dart:math';
import 'package:souglink/login_signup/signup_page.dart';

class FifthStart extends StatelessWidget {
  const FifthStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FifthStartAnimation();
  }
}

class FifthStartAnimation extends StatefulWidget {
  const FifthStartAnimation({super.key});

  @override
  _FifthStartAnimationState createState() => _FifthStartAnimationState();
}

class _FifthStartAnimationState extends State<FifthStartAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ' لنبدأ معًا رحلتنا!',
            style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 32,
                color: const Color.fromARGB(244, 255, 204, 41),
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'قم بالتسجيل أو تسجيل الدخول للبدء في رحلتك نحو شبكة زراعية أكثر اتصالاً وكفاءة وربحية.',
              style: TextStyle(
                  fontFamily: 'Kanit',
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 300, end: 0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: Container(
                    width: 285,
                    height: 276,
                    child: Transform.rotate(
                      angle: pi / 6,
                      child: Image.asset(
                        'assets/images/FifthStart.png',
                      ),
                    ),
                  ),
                );
              }),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the sign-up page when the button is tapped
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
                child: Text(
                  "ابدأ",
                  style: TextStyle(
                      fontFamily: 'Kanit', fontWeight: FontWeight.w600),
                  textDirection: TextDirection.rtl,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 71, 118, 0),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
