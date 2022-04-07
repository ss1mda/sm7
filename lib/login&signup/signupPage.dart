//signupPage.dart
import 'dart:convert';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sm7/login&signup/utility/constants(login).dart';
import 'package:sm7/login&signup/model/userModel.dart';
import 'package:sm7/login&signup/loginPage.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class CreateAccount extends StatefulWidget {
  final List<CameraDescription>? cameras;
  CreateAccount(this.cameras);
  // const CreateAccount({Key? key}) : super(key: key);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

Future<UserModel> createAccount(
    String name, String email, String password) async {
  String url = "http://35.77.144.191:8001/accounts";

  final response = await http.post(Uri.parse(url),
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "password": password
      }));
  final data = response.body;
  print(data);
  if (response.statusCode == 201) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    throw Exception("Failed");
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog(
      {required this.title,
      required this.description,
      required this.buttonText,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(description, style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TextButton(
                    child: Text("Confirm"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen(cameras!)));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade600,
            backgroundImage: const AssetImage('assets/XLpr.gif'),
            radius: 50,
          ),
          top: 0,
          left: 16,
          right: 16,
        )
      ],
    );
  }
}

class _CreateAccountState extends State<CreateAccount> {
  bool _rememberMe = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  Widget _buildBranchNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Branch Name',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _name,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter Branch Name';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.coffee,
                color: Colors.white,
              ),
              hintText: 'Enter your Branch Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter Email';
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _password,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter Password';
              }
              return null;
            },
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.white,
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final String name = _name.text;
            final String email = _email.text;
            final String password = _password.text;

            final UserModel user = await createAccount(name, email, password);

            setState(() {
              final _user = user;
            });

            showDialog(
                context: context,
                builder: (_) => CustomDialog(
                      title: "Success",
                      description: "signUp Complete",
                      buttonText: "abc",
                      image: Image.asset('/assets/XLpr.gif'),
                    ));
          }
        },
        child: const Text(
          'REGISTER',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSigninBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(195, 0, 0, 0),
                      Color.fromARGB(215, 0, 0, 0),
                      Color.fromARGB(235, 0, 0, 0),
                      Color.fromARGB(252, 0, 0, 0),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        _buildBranchNameTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildEmailTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildRegisterBtn(),
                        _buildSigninBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
