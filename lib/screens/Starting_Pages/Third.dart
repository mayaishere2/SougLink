import 'package:flutter/material.dart';
import 'package:souglink/screens/Starting_Pages/Fourth.dart';
class ThirdStart extends StatelessWidget {
  const ThirdStart({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirdStartAnimation();
  }
}

class ThirdStartAnimation extends StatefulWidget {
  const ThirdStartAnimation({super.key});

  @override
  _ThirdStartAnimationState createState() => _ThirdStartAnimationState();
}

class _ThirdStartAnimationState extends State<ThirdStartAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 78, 5),
      body: GestureDetector(
        onTap: () => {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, ThirdaryAnimation) =>
                  FourthStart(),
              transitionsBuilder:
                  (context, animation, ThirdaryAnimation, child) {
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
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'إدارة ',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'السوق',
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
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: Text(
                'ابق على اطلاع بمخزونك واحصل على إشعارات عند انخفاض الكميات. تصفح المنتجات المتوفرة بالقرب منك، قارن الأسعار، واعثر على أفضل العروض لعملائك.',
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
              padding: const EdgeInsets.fromLTRB(40, 20, 30, 0),
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
                          'assets/images/ThirdStart.png',
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 40, 10, 50),
                    child: Icon(
                      Icons.circle,
                      color: index == 1
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
