// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/custom_icons.dart';
import 'package:sm7/utilities/constants(login).dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      home : EmptyCheck(
        title : title,
        channel: IOWebSocketChannel.connect("ws://35.77.144.191/ws/detectData")
      )
    );
  }
}

class EmptyCheck extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;
  EmptyCheck({Key? key, required this.title, required this.channel})
      : super(key: key);
  @override
  _EmptyCheckState createState() => _EmptyCheckState();
}

final Map<String, dynamic> jsonString2 = {
  // 'table1': {
  //   //테이블1
  //   'chair': {
  //     'up': 2, //0빈자리, 1마스크한사람, 2마스크안한사람, 3error
  //     'down': 0
  //   },
  //   'object': {
  //     "notebook": 0, //노트북 갯수
  //     "book": 0, //책 갯수
  //     "bag": 0, //가방 갯수
  //     "cup": 0 // 컵 갯수
  //   }
  // },
  // 'table2': {
  //   //테이블2
  //   'chair': {
  //     'up':2, //0빈자리, 1마스크한사람, 2마스크안한사람, 3error
  //     'down': 0
  //   },
  //   'object': {
  //     "notebook": 2, //노트북 갯수
  //     "book": 0, //책 갯수
  //     "bag": 0, //가방 갯수
  //     "cup": 0 // 컵 갯수
  //   }
  // },
  // 'table3': {
  //   //테이블3
  //   'chair': {
  //     'up': 1, //0빈자리, 1마스크한사람, 2마스크안한사람, 3error
  //     'down': 3
  //   },
  //   'object': {
  //     "notebook": 1, //노트북 갯수
  //     "book": 0, //책 갯수
  //     "bag": 2, //가방 갯수
  //     "cup": 2 // 컵 갯수
  //   }
  // }
};
//바뀐거로


class myPainter extends CustomPainter {
  String target;
  myPainter(this.target);

  void _emptytable(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-80, -30) & const Size(160, 60), paint);
  }

  void _table(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-80, -30) & const Size(160, 60), paint);
  }

  void _noperson(Canvas canvas, Size size) {
    final icon = Icons.chair_outlined;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(text: String.fromCharCode(icon.codePoint),
        style: TextStyle(fontSize: 50.0,fontFamily: icon.fontFamily, color : Colors.grey[600]));
    textPainter.layout();
    textPainter.paint(canvas, Offset(-25,-25));
    // Paint paint = Paint()
    //   ..color = Colors.grey
    //   ..style = PaintingStyle.fill;
    // canvas.drawCircle(Offset(0, 0), 20, paint);
  }

  void _person_mask(Canvas canvas, Size size) {
    // final icon = Icons.masks;
    final icon = CustomIcons.mask2;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(text: String.fromCharCode(icon.codePoint),
        style: TextStyle(fontSize: 60.0,fontFamily: icon.fontFamily, color : Colors.green));
    textPainter.layout();
    textPainter.paint(canvas, Offset(-30,-30));
    // Paint paint = Paint();
    //   ..color = Colors.blue
    //   ..style = PaintingStyle.fill;
    // canvas.drawCircle(Offset(0, 0), 20, paint);
  }

  void _person_nomask(Canvas canvas, Size size) {
    // final icon = Icons.person_outlined;
    final icon = CustomIcons.mask2_2;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(text: String.fromCharCode(icon.codePoint),
        style: TextStyle(fontSize: 60.0,fontFamily: icon.fontFamily, color : Colors.red));
    textPainter.layout();
    textPainter.paint(canvas, Offset(-30,-30));
    // Paint paint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.fill;
    // canvas.drawCircle(Offset(0, 0), 20, paint);
  }

  void table1_person(Canvas canvas, Size size) {
    //p2, table1
    if (target == "p1" &&
        jsonString2["table1"]["chair"].keys.elementAt(0) == "up") {
      //p1, table1, up
      if (jsonString2["table1"]["chair"]["up"] == 0) {
        _noperson(canvas, size);
      } else if (jsonString2["table1"]["chair"]["up"] == 1) {
        _person_mask(canvas, size);
      } else if (jsonString2["table1"]["chair"]["up"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    } else if (target == "p2" &&
        jsonString2["table1"]["chair"].keys.elementAt(1) == "down") {
      //p2, table, down
      if (jsonString2["table1"]["chair"]["down"] == 0) {
        _noperson(canvas, size);
      } else if (jsonString2["table1"]["chair"]["down"] == 1) {
        _person_mask(canvas, size);
      } else if (jsonString2["table1"]["chair"]["down"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    }
  }

  void table2_person(Canvas canvas, Size size) {
    if (target == "p3" &&
        jsonString2["table2"]["chair"].keys.elementAt(0) == "up") {
      if (jsonString2["table2"]["chair"]["up"] == 0) {
        _noperson(canvas, size);
      } else if (jsonString2["table2"]["chair"]["up"] == 1) {
        _person_mask(canvas, size);
      } else if (jsonString2["table2"]["chair"]["up"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    } else if (target == "p4" &&
        jsonString2["table2"]["chair"].keys.elementAt(1) == "down") {
      if (jsonString2["table2"]["chair"]["down"] == 0) {
        _noperson(canvas, size);
      } else if (jsonString2["table2"]["chair"]["down"] == 1) {
        _person_mask(canvas, size);
      } else if (jsonString2["table2"]["chair"]["down"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    }
  }

  void table3_person(Canvas canvas, Size size) {
    if (target == "p5" &&
        jsonString2["table3"]["chair"].keys.elementAt(0) == "up") {
      if (jsonString2["table3"]["chair"]["up"] == 0) {
        _noperson(canvas, size);
      } else if (jsonString2["table3"]["chair"]["up"] == 1) {
        _person_mask(canvas, size);
      } else if (jsonString2["table3"]["chair"]["up"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    } else if (target == "p6" &&
        jsonString2["table3"]["chair"].keys.elementAt(1) == "down") {
      if (jsonString2["table3"]["chair"]["down"] == 0) {
        _noperson(canvas, size);
      } else if (jsonString2["table3"]["chair"]["down"] == 1) {
        _person_mask(canvas, size);
      } else if (jsonString2["table3"]["chair"]["down"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    }
  }

  // 테이블과 사람을 확인하여 빈자리 유무 확인
  void table1(Canvas canvas, Size size) {
    if (target == 't1' && jsonString2["table1"].keys.elementAt(1) == "object") {
      if ((jsonString2["table1"]['object']['notebook'] == 0) &&
          (jsonString2["table1"]['object']['book'] == 0) &&
          (jsonString2["table1"]['object']['bag'] == 0) &&
          (jsonString2["table1"]['object']['cup'] == 0) &&
          (jsonString2["table1"]['chair']['up'] == 0) &&
          (jsonString2["table1"]['chair']['down'] == 0)
      ) {
        _emptytable(canvas, size);
      } else {
        _table(canvas, size);
      }
    }
  }

  void table2(Canvas canvas, Size size) {
    if (target == 't2' && jsonString2["table2"].keys.elementAt(1) == "object") {
      if ((jsonString2["table2"]['object']['notebook'] == 0) &&
          (jsonString2["table2"]['object']['book'] == 0) &&
          (jsonString2["table2"]['object']['bag'] == 0) &&
          (jsonString2["table2"]['object']['cup'] == 0) &&
          (jsonString2["table2"]['chair']['up'] == 0) &&
          (jsonString2["table2"]['chair']['down'] == 0)
      ) {
        _emptytable(canvas, size);
      } else {
        _table(canvas, size);
      }
    }
  }

  void table3(Canvas canvas, Size size) {
    if (target == 't3' && jsonString2["table1"].keys.elementAt(1) == "object") {
      if ((jsonString2["table3"]['object']['notebook'] == 0) &&
          (jsonString2["table3"]['object']['book'] == 0) &&
          (jsonString2["table3"]['object']['bag'] == 0) &&
          (jsonString2["table3"]['object']['cup'] == 0) &&
          (jsonString2["table3"]['chair']['up'] == 0) &&
          (jsonString2["table3"]['chair']['down'] == 0)
      ) {
        _emptytable(canvas, size);
      } else {
        _table(canvas, size);
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 3; i++) {
      if (jsonString2.keys.elementAt(i) == "table1") {
        //table1일경우
        table1_person(canvas, size);
        table1(canvas, size);
      } else if (jsonString2.keys.elementAt(i) == "table2") {
        //table2일경우만
        table2_person(canvas, size);
        table2(canvas, size);
      } else {
        table3_person(canvas, size);
        table3(canvas, size);
      }
    }
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
      appBar: AppBar(
        title: Text("좌석 & 마스크 확인", style: TextStyle(fontSize: 20.0)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
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
              SafeArea(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // StreamBuilder(
                          //   stream: widget.channel.stream,
                          //   builder: (context, snapshot) {
                          //     return Padding(
                          //       padding: const EdgeInsets.symmetric(vertical: 24.0),
                          //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                          //     );
                          //   },
                          // ),
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p1"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("t1"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p2"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p3"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("t2"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p4"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p5"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("t3"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            child: CustomPaint(
                              painter: myPainter("p6"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}