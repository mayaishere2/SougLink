import 'package:flutter/material.dart';
import 'package:souglink/Starting_Pages/Second.dart';

class FirstStart extends StatelessWidget {
  const FirstStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FirstStartAnimation();
  }
}

class FirstStartAnimation extends StatefulWidget {
  const FirstStartAnimation({super.key});

  @override
  _FirstStartAnimationState createState() => _FirstStartAnimationState();
}

class _FirstStartAnimationState extends State<FirstStartAnimation> {
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
                  SecondStart(),
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
              height: 50,
            ),
            Align(
              alignment: Alignment(0.6, 0),
              child: Text(
                'مرحبًا بك في',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment(-0.5, 0),
              child: Text(
                'SougLink',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 36,
                    color: const Color.fromARGB(244, 255, 204, 41),
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'اتصل بالمزارعين والأسواق بشكل لم يسبق له مثيل. انضم إلى شبكة تتيح للمزارعين إدارة محاصيلهم وتمنح البائعين فرصة للوصول إلى منتجات طازجة بأسعار تنافسية.',
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
                        height: 276,
                        child: Image.asset(
                          'assets/images/FirstStart.png',
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 50),
                    child: Icon(
                      Icons.circle,
                      color: index == 3
                          ? Color.fromARGB(244, 255, 204, 41)
                          : Colors.grey,
                      size: 12,
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
