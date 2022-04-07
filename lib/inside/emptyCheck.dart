// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm7/custom_icons.dart';
// import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EmptyCheck_first extends StatelessWidget {
  const EmptyCheck_first({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: EmptyCheck(
          //웹 소켓 채널 연결
            channel: WebSocketChannel.connect(
                Uri.parse('ws://35.77.144.191/ws/detectData'))));
  }
}

class EmptyCheck extends StatefulWidget {
  final WebSocketChannel? channel;
  EmptyCheck({
    Key? key,
    this.channel,
  }) : super(key: key);
  @override
  _EmptyCheckState createState() => _EmptyCheckState();
}

Map<String, dynamic>? result;
//초기값
Map<String, dynamic>? yolo_result = {
  // 테이블 / 0빈자리, 1마스크한사람, 2마스크안한사람 /  3error 노트북 갯수, 책 갯수, 가방 갯수, 컵 갯수
  'table1': {
    'chair': {'up': 0, 'down': 0},
    'object': {"notebook": 0, "book": 0, "bag": 0, "cup": 0}
  },
  'table2': {
    'chair': {'up': 0, 'down': 0},
    'object': {"notebook": 0, "book": 0, "bag": 0, "cup": 0}
  },
  'table3': {
    'chair': {'up': 0, 'down': 0},
    'object': {"notebook": 0, "book": 0, "bag": 0, "cup": 0}
  }
};

// Map<String, dynamic>? yolo_result2 = yolo_result;

class myPainter extends CustomPainter {
  String target;
  myPainter(this.target);

  void _emptytable(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-80, -24) & const Size(160, 48), paint);
  }

  void _table(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(-80, -24) & const Size(160, 48), paint);
  }

  //빈자리
  void _noperson(Canvas canvas, Size size) {
    final icon = Icons.chair_outlined;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: 46.0,
            fontFamily: icon.fontFamily,
            color: Colors.grey[600]));
    textPainter.layout();
    textPainter.paint(canvas, Offset(-23, -23));
  }

  //마스크낀사람
  void _person_mask(Canvas canvas, Size size) {
    final icon = CustomIcons.mask2;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: 48.0, fontFamily: icon.fontFamily, color: Colors.green));
    textPainter.layout();
    textPainter.paint(canvas, Offset(-24, -24));
  }

  //마스크안낀사람
  void _person_nomask(Canvas canvas, Size size) {
    final icon = CustomIcons.mask2_2;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
            fontSize: 48.0, fontFamily: icon.fontFamily, color: Colors.red));
    textPainter.layout();
    textPainter.paint(canvas, Offset(-24, -24));
  }

  //table별 사람들 그리기
  //table1의 사람들
  void table1_person(Canvas canvas, Size size) {
    //p2, table1
    if (target == "p1" &&
        yolo_result?["table1"]["chair"].keys.elementAt(0) == "up") {
      //p1, table1, up
      if (yolo_result?["table1"]["chair"]["up"] == 0) {
        _noperson(canvas, size);
      } else if (yolo_result?["table1"]["chair"]["up"] == 1) {
        _person_mask(canvas, size);
      } else if (yolo_result?["table1"]["chair"]["up"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    } else if (target == "p2" &&
        yolo_result?["table1"]["chair"].keys.elementAt(1) == "down") {
      //p2, table, down
      if (yolo_result?["table1"]["chair"]["down"] == 0) {
        _noperson(canvas, size);
      } else if (yolo_result?["table1"]["chair"]["down"] == 1) {
        _person_mask(canvas, size);
      } else if (yolo_result?["table1"]["chair"]["down"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    }
  }

  //table2의 사람들
  void table2_person(Canvas canvas, Size size) {
    if (target == "p3" &&
        yolo_result?["table2"]["chair"].keys.elementAt(0) == "up") {
      if (yolo_result?["table2"]["chair"]["up"] == 0) {
        _noperson(canvas, size);
      } else if (yolo_result?["table2"]["chair"]["up"] == 1) {
        _person_mask(canvas, size);
      } else if (yolo_result?["table2"]["chair"]["up"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    } else if (target == "p4" &&
        yolo_result?["table2"]["chair"].keys.elementAt(1) == "down") {
      if (yolo_result?["table2"]["chair"]["down"] == 0) {
        _noperson(canvas, size);
      } else if (yolo_result?["table2"]["chair"]["down"] == 1) {
        _person_mask(canvas, size);
      } else if (yolo_result?["table2"]["chair"]["down"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    }
  }

  //table3의 사람들
  void table3_person(Canvas canvas, Size size) {
    if (target == "p5" &&
        yolo_result?["table3"]["chair"].keys.elementAt(0) == "up") {
      if (yolo_result?["table3"]["chair"]["up"] == 0) {
        _noperson(canvas, size);
      } else if (yolo_result?["table3"]["chair"]["up"] == 1) {
        _person_mask(canvas, size);
      } else if (yolo_result?["table3"]["chair"]["up"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    } else if (target == "p6" &&
        yolo_result?["table3"]["chair"].keys.elementAt(1) == "down") {
      if (yolo_result?["table3"]["chair"]["down"] == 0) {
        _noperson(canvas, size);
      } else if (yolo_result?["table3"]["chair"]["down"] == 1) {
        _person_mask(canvas, size);
      } else if (yolo_result?["table3"]["chair"]["down"] == 2) {
        _person_nomask(canvas, size);
      } else {
        _person_nomask(canvas, size);
      }
    }
  }

  // 테이블과 사람을 확인하여 빈자리 유무 확인
  //table1 그리기
  void table1(Canvas canvas, Size size) {
    if (target == 't1' &&
        yolo_result?["table1"].keys.elementAt(1) == "object") {
      if ((yolo_result?["table1"]['object']['notebook'] == 0) &&
          (yolo_result?["table1"]['object']['book'] == 0) &&
          (yolo_result?["table1"]['object']['bag'] == 0) &&
          (yolo_result?["table1"]['object']['cup'] == 0) &&
          (yolo_result?["table1"]['chair']['up'] == 0) &&
          (yolo_result?["table1"]['chair']['down'] == 0)) {
        _emptytable(canvas, size);
      } else {
        _table(canvas, size);
      }
    }
  }

  //table3 그리기
  void table2(Canvas canvas, Size size) {
    if (target == 't2' &&
        yolo_result?["table2"].keys.elementAt(1) == "object") {
      if ((yolo_result?["table2"]['object']['notebook'] == 0) &&
          (yolo_result?["table2"]['object']['book'] == 0) &&
          (yolo_result?["table2"]['object']['bag'] == 0) &&
          (yolo_result?["table2"]['object']['cup'] == 0) &&
          (yolo_result?["table2"]['chair']['up'] == 0) &&
          (yolo_result?["table2"]['chair']['down'] == 0)) {
        _emptytable(canvas, size);
      } else {
        _table(canvas, size);
      }
    }
  }

  //table3 그리기
  void table3(Canvas canvas, Size size) {
    if (target == 't3' &&
        yolo_result?["table1"].keys.elementAt(1) == "object") {
      if ((yolo_result?["table3"]['object']['notebook'] == 0) &&
          (yolo_result?["table3"]['object']['book'] == 0) &&
          (yolo_result?["table3"]['object']['bag'] == 0) &&
          (yolo_result?["table3"]['object']['cup'] == 0) &&
          (yolo_result?["table3"]['chair']['up'] == 0) &&
          (yolo_result?["table3"]['chair']['down'] == 0)) {
        _emptytable(canvas, size);
      } else {
        _table(canvas, size);
      }
    }
  }

  //그림 그리기 시작
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 3; i++) {
      //table1일경우
      if (yolo_result?.keys.elementAt(i) == "table1") {
        //table1의 person
        table1_person(canvas, size);
        //table1
        table1(canvas, size);
        //table2일경우
      } else if (yolo_result?.keys.elementAt(i) == "table2") {
        //table2의 person
        table2_person(canvas, size);
        //table2
        table2(canvas, size);
        //table3일경우
      } else {
        //table3의 person
        table3_person(canvas, size);
        //table3
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
              // Visibility(child: Text(yolo_result.toString()),visible: true),
              StreamBuilder(
                // initialData: yolo_result_initial,
                stream: widget.channel?.stream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                    //   Container(
                    //     child: Center(
                    //         child:
                    //         Text( "Loading...", style: TextStyle(fontSize: 25, color: Colors.white),
                    // )));
                  } else
                    yolo_result = jsonDecode('${snapshot.data}');
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: SafeArea(
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(yolo_result.toString(),
                                      style: TextStyle(
                                          fontSize: 5,
                                          color: Colors.black.withOpacity(0))),
                                  SizedBox(
                                    height: 45,
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
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
