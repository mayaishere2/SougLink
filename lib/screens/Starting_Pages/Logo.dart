import 'package:flutter/material.dart';
import 'First.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return logoAnimation();
  }
}

class logoAnimation extends StatefulWidget {
  const logoAnimation({super.key});

  @override
  _logoAnimationState createState() => _logoAnimationState();
}

class _logoAnimationState extends State<logoAnimation> {
  void Translation() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstStart()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
      body: Center(
        child: TweenAnimationBuilder(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 50, end: 141),
          builder: (context, size, child) {
            if (size == 141) {
              Translation();
            }

            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
