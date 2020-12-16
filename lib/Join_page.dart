import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(JoinPage());
}

const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
const SubColor = Color.fromRGBO(241, 230, 250, 1);

class JoinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();

  bool _success;
  String _userEmail;
  String _error;

  String name;
  String birth;
  String phone;
  String email;
  String password;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  Future<void> _inputUser() {
    return user
        .doc('$email')
        .set({
          'name': '$name',
          'birth': '$birth',
          'phone': '$phone',
          'email': '$email',
          'password': '$password',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<void> _inputUsers() {
    return users
        .doc('$name')
        .set({
          'name': '$name',
          'birth': '$birth',
          'phone': '$phone',
          'email': '$email',
          'password': '$password',
        })
        .then((value) => print("Users Added"))
        .catchError((error) => print('Failed to add users: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(168, 114, 207, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:
              Text('회원가입', style: TextStyle(fontSize: 19, color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              color: Colors.black45,
              icon: Icon(Icons.arrow_back)),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  width: 1000,
                  child: Text('이름',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: _nameController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(
                          RegExp("[a-zA-Z가-하각-힇ㄱ-ㅎㅏ-ㅣ]")),
                    ],
                    decoration: InputDecoration(
                      focusColor: PrimaryColor,
                      border: OutlineInputBorder(),
                      hintText: "이름을 입력해주세요.",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '이름을 입력하세요';
                      }
                      name = value;
                      return null;
                    },
                  ),
                  height: 100,
                ),
                Container(
                  width: 1000,
                  child: Text('생년월일',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: _birthController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "ex) 761116",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '생년월일을 입력하세요';
                      }
                      birth = value;
                      return null;
                    },
                  ),
                  height: 100,
                ),
                Container(
                  width: 1000,
                  child: Text('핸드폰 번호',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "핸드폰 번호를 입력해주세요.",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '핸드폰 번호를 입력하세요';
                      }
                      phone = value;
                      return null;
                    },
                  ),
                  height: 100,
                ),
                Container(
                  width: 1000,
                  child: Text('이메일',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "회원가입할 이메일을 입력해주세요.",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '이메일을 입력하세요';
                      }
                      email = value;
                      return null;
                    },
                  ),
                  height: 100,
                ),
                Container(
                  width: 1000,
                  child: Text('비밀번호',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "비밀번호를 입력해주세요.",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '비밀번호를 입력하세요';
                      }
                      password = value;
                      return null;
                    },
                  ),
                  height: 100,
                ),
                Container(
                  width: 1000,
                  child: Text('비밀번호 확인',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                      controller: _password1Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "비밀번호를 한번 더 입력해주세요.",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "비밀번호 확인을 입력하세요";
                        } else if (password != value) {
                          return "비밀번호가 일치하지 않습니다";
                        }
                        return null;
                      }),
                  height: 100,
                ),
                Container(
                  //margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.only(top: 8),
                  width: 350,
                  height: 75,
                  //alignment: Alignment.topCenter,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _register();
                        _inputUser();
                        _inputUsers();
                        Navigator.push(
                            //DB처리
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    textColor: Colors.white,
                    color: Color.fromRGBO(168, 114, 207, 1),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _birthController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password1Controller.dispose();
    super.dispose();
  }

  //사용자 등록 처리
  void _register() async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
      } else {
        setState(() {
          _success = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _error = e.toString();
        _success = false;
      });
    }
  }
}
