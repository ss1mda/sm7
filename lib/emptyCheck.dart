// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/utilities/constants(login).dart';

class EmptyCheck extends StatefulWidget {
  @override
  _EmptyCheckState createState() => _EmptyCheckState();
}

class myPainter extends CustomPainter
{
  const myPainter();
  final int condition = 1;

  @override
  void paint(Canvas canvas, Size size) {
    if (condition == 1) {
      _person_mask(canvas, size);
    }else
    {
      _person_nomask(canvas,size);
    }
    // TODO: implement paint
  }

  void _person_mask(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width.toInt() / 2, size.width.toInt() / 2), 20, paint);
    // TODO: implement paint
  }

  void _person_nomask(Canvas canvas,Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width.toInt() / 2, size.width.toInt() / 2), 20, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _EmptyCheckState extends State<EmptyCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Color.fromARGB(195, 0, 0, 0),
                      Color.fromARGB(215, 0, 0, 0),
                      Color.fromARGB(235, 0, 0, 0),
                      Color.fromARGB(252, 0, 0, 0),
                    ],
                    stops: const [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child:CustomPaint(
                            painter: myPainter(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text('테이블 1'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 10,
                          width: 100,
                          alignment: Alignment.centerRight,
                          child:CustomPaint(
                            painter: myPainter(),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text('테이블 2'),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text('테이블 3'),
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
