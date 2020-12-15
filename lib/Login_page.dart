import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Join_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
const SubColor = Color.fromRGBO(241, 230, 250, 1);

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
String email;

class FirebaseAuthService with ChangeNotifier, DiagnosticableTreeMixin {
  String _loginEmail;
  String _userName;
  String _userPhone;
  String _userPeople;
  String _userDate;
  String _townName;
  String _townAddress;

  String get loginEmail => _loginEmail;
  String get userName => _userName;
  String get userPhone => _userPhone;
  String get userPeople => _userPeople;
  String get userDate => _userDate;
  String get townName => _townName;
  String get townAddress => _townAddress;

  void increment(email){
    _loginEmail = '$email';
    notifyListeners();
  }
  void incrementName(name){
    _userName = '$name';
    notifyListeners();
  }
  void incrementPhone(phone){
    _userPhone = '$phone';
    notifyListeners();
  }
  void incrementPeople(people){
    _userPeople = '$people';
    notifyListeners();
  }
  void incrementDate(date){
    _userDate = '$date';
    notifyListeners();
  }
  void incrementTownName(name){
    _townName = '$name';
    notifyListeners();
  }
  void incrementTownAddress(address){
    _townAddress = '$address';
    notifyListeners();
  }

  void decrement(){
    _loginEmail = null;
    notifyListeners();
  }
  void decrementName(){
    _userName = null;
    notifyListeners();
  }
  void decrementPhone(){
    _userPhone = null;
    notifyListeners();
  }
  void decrementPeople(){
    _userPeople = null;
    notifyListeners();
  }
  void decrementDate(){
    _userDate = null;
    notifyListeners();
  }
  /*
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', _loginemail));
  }*/

  FirebaseAuthService({auth}) : _auth = auth ?? FirebaseAuth.instance;
  FirebaseAuth _auth;

  Future<FirebaseUser> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final credential = EmailAuthProvider.getCredential(
      email: email,
      password: password,
    );
    final authResult = await _auth.signInWithCredential(credential);
    return authResult.user;
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuthService _auth;

  bool _success;
  String _userEmail;
  String _error;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthService>(context, listen:false);
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
                                  context.read<FirebaseAuthService>().increment(email);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp())
                                  );
                                }
                              },
                              child: Text('로그인',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              textColor: Colors.white,
                              color: PrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                                //Text(_error == null
                                //    ? ''
                                //    : _error),
                              ],
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
      final user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ));

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
          email = user.email;
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
