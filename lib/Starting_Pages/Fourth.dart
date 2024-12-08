import 'package:flutter/material.dart';
import 'package:souglink/Starting_Pages/Fifth.dart';

class FourthStart extends StatelessWidget {
  const FourthStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FourthStartAnimation();
  }
}

class FourthStartAnimation extends StatefulWidget {
  const FourthStartAnimation({super.key});

  @override
  _FourthStartAnimationState createState() => _FourthStartAnimationState();
}

class _FourthStartAnimationState extends State<FourthStartAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
      body: GestureDetector(
        onTap: () => {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, FourtharyAnimation) =>
                  FifthStart(),
              transitionsBuilder:
                  (context, animation, FourtharyAnimation, child) {
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'اكتشف',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ' أفضل العروض',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 32,
                            color: const Color.fromARGB(244, 255, 204, 41),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'بالقرب منك',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'اطلع على متوسط أسعار المنتجات في منطقتك بناءً على بيانات المزارعين. قارن الأسعار في الوقت الفعلي واتخذ قرارات مدروسة تدعم نجاح أعمالك.',
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
              padding: const EdgeInsets.all(8),
              child: TweenAnimationBuilder(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 300, end: 0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value, 0),
                      child: Container(
                        width: 343,
                        height: 240,
                        child: Image.asset(
                          'assets/images/FourthStart.png',
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.circle,
                      color: index == 0
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
