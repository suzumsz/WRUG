import 'package:flutter/material.dart';
import 'main.dart';
import 'Join_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  String _email;
  String _password;

  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromRGBO(168, 114, 207, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  color: Colors.black45,
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
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
                          onChanged: (result) {
                            _email = result;
                          },
                          /*onSaved: (String value) {
                            _email = value;
                          },*/
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'password',
                          ),
                          onChanged: (result) {
                            _password = result;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return '비밀번호를 확인해 주세요.';
                            }
                            return null;
                          },
                          /*onSaved: (String value) {
                            _password = value;
                          },*/
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
                            print(_email + '\n' + _password);
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            /* Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        MyApp()));
                                _formKey.currentState.save();

                                print(_email);
                                print(_password);*/

                            // var authHandler = new Auth();
                            // authHandler
                            //     .handleSignInEmail(_email, _password)
                            //     .then((FirebaseUser user) {
                            //   Navigator.push(
                            //       context,
                            //       new MaterialPageRoute(
                            //           builder: (context) => MainPage()));
                            // }).catchError((e) => print(e));
                          },
                          child: Text('로그인', style: TextStyle(fontSize: 15)),
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
                    ])))));
  }
}

// class Auth {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future<FirebaseUser> handleSignInEmail(String email, String password) async {
//     AuthResult result =
//     await auth.signInWithEmailAndPassword(email: email, password: password);
//     final FirebaseUser user = result.user;
//
//     assert(user != null);
//     assert(await user.getIdToken() != null);
//
//     final FirebaseUser currentUser = await auth.currentUser();
//     assert(user.uid == currentUser.uid);
//
//     print('signInEmail succeeded: $user');
//
//     return user;
//   }
//
//   Future<FirebaseUser> handleSignUp(email, password) async {
//     AuthResult result = await auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     final FirebaseUser user = result.user;
//
//     assert(user != null);
//     assert(await user.getIdToken() != null);
//
//     return user;
//   }
// }