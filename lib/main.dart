import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sm7/login&signup/loginPage.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: Text("SM7",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen(cameras!)));
        },
      )),
      backgroundColor: Color.fromARGB(252, 0, 0, 0),
    );
  }
}
