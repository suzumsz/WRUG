import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Join_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
const SubColor = Color.fromRGBO(241, 230, 250, 1);

final FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

String email;

class FirebaseAuthService with ChangeNotifier, DiagnosticableTreeMixin {
  bool _loggedIn = false; // 로그인 상태
  String _loginEmail; // 사용자 이메일
  String _userName; // 사용자 이름
  String _userPhone; // 사용자 전화번호
  String _userPeople; // 인원수
  String _userDate; // 예약날짜
  String _townName;
  String _townAddress;

  bool get loggedIn => _loggedIn;
  String get loginEmail => _loginEmail;
  String get userName => _userName;
  String get userPhone => _userPhone;
  String get userPeople => _userPeople;
  String get userDate => _userDate;
  String get townName => _townName;
  String get townAddress => _townAddress;

  // 로그인 후 이부분에서 firebase인증처리가 이루어져야함
  Future<void> updateLoggedIn() async {
    print('로그인 정보 등록');
    final User user = await _auth.currentUser;

    var document = _firestore.collection('user').document(user.email).get();
    await document.then((doc) {
      _loggedIn = true;
      _loginEmail = user.email;
      _userName = doc['name'];
      _userPhone = doc['phone'];
    });

    notifyListeners();
  }

  // 로그아웃
  void updateLoggedOut() {
    print('로그인 정보 삭제');
    _loggedIn = false;
    _loginEmail = null;
    _userName = null;
    _userPhone = null;
    _userPeople = null;
    _userDate = null;
    notifyListeners();
  }

  void incrementPeople(people) {
    _userPeople = '$people';
    notifyListeners();
  }

  void incrementDate(date) {
    _userDate = '$date';
    notifyListeners();
  }

  void incrementTownName(name) {
    _townName = '$name';
    notifyListeners();
  }

  void incrementTownAddress(address) {
    _townAddress = '$address';
    notifyListeners();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(168, 114, 207, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('로그인',
                style: TextStyle(fontSize: 19, color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                color: Colors.black45,
                icon: Icon(Icons.arrow_back)),
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: 1000,
                          child: Text('  이메일',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 17)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.center,
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
                          child: Text('  비밀번호',
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
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _signIn();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              }
                            },
                            child: Text('로그인',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            textColor: Colors.white,
                            color: PrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),

                        // 사용자 로그인 처리 결과
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text(_success == null
                                  ? ''
                                  : (_success ? '' : '로그인에 실패하였습니다')),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
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
                                          fontSize: 13, color: Colors.black45)),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JoinPage()));
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
        print('로그인 성공');
        setState(() {
          _success = true;
        });
        context.read<FirebaseAuthService>().updateLoggedIn();
      } else {
        setState(() {
          _success = false;
        });
        context.read<FirebaseAuthService>().updateLoggedOut();
      }
    } catch (e) {
      print(e);
      setState(() {
        _success = false;
        print('오류: ' + e.toString());
      });
      context.read<FirebaseAuthService>().updateLoggedOut();
    }
  }
}
