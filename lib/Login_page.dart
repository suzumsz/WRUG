import 'package:flutter/material.dart';
import 'main.dart';
import 'Join_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
const SubColor = Color.fromRGBO(241, 230, 250, 1);

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;
  String _error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(168, 114, 207, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        key: _formKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('로그인',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
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
            child: Card(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 1000,
                            child: Text('     이메일',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 17)),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 350.0,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'example@example.com',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return '이메일을 확인해 주세요.';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 1000,
                            child: Text('     비밀번호',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 17)),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 350.0,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'password',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return '비밀번호를 확인해 주세요.';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: 350.0,
                            height: 60.0,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _signIn();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                }
                              },
                              child:
                                  Text('로그인', style: TextStyle(fontSize: 15)),
                              textColor: Colors.white,
                              color: PrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Text(_success == null
                                    ? ''
                                    : (_success
                                        ? '사용자 로그인에 성공하였습니다.\n 이메일: ' +
                                            _userEmail
                                        : '사용자 로그인에 실패하였습니다')),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(_error == null ? '' : _error),
                              ],
                            ),
                          ),
                          Container(
                              width: 1000,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    child: Text('아직 회원이 아니신가요?   ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black45)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JoinPage()));
                                    },
                                    child: Text('회원가입',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: PrimaryColor)),
                                  )
                                ],
                              )),
                        ])))),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //사용자 로그인 처리
  void _signIn() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
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
