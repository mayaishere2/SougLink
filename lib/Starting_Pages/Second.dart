import 'package:flutter/material.dart';
import 'package:souglink/Starting_Pages/Third.dart';
class SecondStart extends StatelessWidget {
  const SecondStart({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondStartAnimation();
  }
}

class SecondStartAnimation extends StatefulWidget {
  const SecondStartAnimation({super.key});

  @override
  _SecondStartAnimationState createState() => _SecondStartAnimationState();
}

class _SecondStartAnimationState extends State<SecondStartAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
      body: GestureDetector(
        onTap: () => {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ThirdStart(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          ),
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تمكين',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    ' المزارعين',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 32,
                        color: const Color.fromARGB(244, 255, 204, 41),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'اتبع حصادك بسهولة يوميًا أو أسبوعيًا أو موسميًا.  احصل على رؤى دقيقة حول مستويات مخزونك،  وتلقَّ إشعارات للمنتجات التي أوشكت على النفاد، وتواصل مباشرة مع تجار السوق لتوسيع نطاق أعمالك.',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TweenAnimationBuilder(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 300, end: 0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value, 0),
                      child: Container(
                        width: 343,
                        height: 276,
                        child: Image.asset(
                          'assets/images/SecondStart.png',
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.circle,
                      color: index == 2
                          ? Color.fromARGB(244, 255, 204, 41)
                          : Colors.grey,
                      size: 12,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
