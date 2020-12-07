import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(JoinPage());
}

class JoinPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '회원가입'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String birth = '';
  String phone = '';
  String email = '';
  String password = '';
  String passwordCheck ='';

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        children: <Widget>[
          Container(
            width: 1000,
            child: Text('   이름', textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17)),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: TextEditingController(),
              inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z가-하각-힇ㄱ-ㅎㅏ-ㅣ]")),],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "이름을 입력해주세요.",
              ),
              validator: (String value){
                if (value.isEmpty){
                  return '이름을 입력해주세요';
                }
                return null;
              },
              onSaved: (String value){
                name = value;
              },
            ),
            height: 100,
          ),
          Container(
            width: 1000,
            child: Text('   생년월일', textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17)),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "ex) 761116",
              ),
              onChanged: (text){
                this.birth = text;
              },
              validator: (String value){
                if (value.isEmpty){
                  return "생년월일을 입력해주세요";
                } else {
                  this.birth=value;
                  return null;
                }
              },
            ),

            height: 100,

          ),
          Container(
            width: 1000,
            child: Text('   핸드폰 번호', textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17)),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]')),],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "핸드폰 번호를 입력해주세요.",
              ),
              onChanged: (text){
                this.phone = text;
              },
              validator: (String value){
                if (value.isEmpty){
                  return "핸드폰 번호를 입력해주세요";
                } else {
                  this.phone=value;
                  return null;
                }
              },
            ),

            height: 100,

          ),
          Container(
            width: 1000,
            child: Text('   이메일', textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17)),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: _email,
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "회원가입할 이메일을 입력해주세요.",
              ),
              onChanged: (text){
                this.email = text;
              },
              validator: (String value){
                if (value.isEmpty){
                  return "이메일을 입력해주세요";
                } else {
                  this.email=value;
                  return null;
                }
              },
            ),

            height: 100,

          ),
          Container(
            width: 1000,
            child: Text('   비밀번호', textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17)),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              // controller: _password,
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "비밀번호를 입력해주세요.",
              ),
              onChanged: (text){
                this.password = text;
              },
              validator: (String value){
                if (value.isEmpty){
                  return "비밀번호를 입력해주세요";
                } else {
                  this.password=value;
                  return null;
                }
              },
            ),

            height: 100,

          ),
          Container(
            width: 1000,
            child: Text('   비밀번호 확인', textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 17)),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "비밀번호를 한번 더 입력해주세요.",
              ),
              onChanged: (text){
                this.passwordCheck = text;
              },
              validator: (String value){
                if (value.isEmpty){
                  return "비밀번호 확인을 입력해주세요";
                }
                else if (password != passwordCheck) {
                  return "비밀번호가 일치하지 않습니다";
                }
                else {
                  this.passwordCheck=value;
                  return null;
                }
              },
            ),

            height: 100,

          ),

          Container(
            //margin: const EdgeInsets.only(top: 16.0),
            padding: const EdgeInsets.all(8.0),
            width:350,
            height: 75,
            //alignment: Alignment.topCenter,
            child: RaisedButton(
              onPressed: () {

                _register();

                if (!_formKey.currentState.validate()) {
                  return;
                }

                //_formKey.currentState.save();

                print(name);
                print(birth);
                print(phone);
                print(email);
                print(password);
                print(passwordCheck);

                Navigator.push(//DB처리
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                },
              child:
              Text('회원가입',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
              textColor: Colors.white,
              color: Color.fromRGBO(168, 114, 207, 1),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          Container(
            width: 350,
            height: 25,
          ),
        ],
      ),
    );
  }

//회원가입 처리
  void _register() async{
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final FirebaseUser user = result.user;

    if (user==null){
      print('회원가입 다시 시도');
    }else{
      print('회원가입 성공');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(168, 114, 207, 1),
        //primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context){
              return IconButton(icon: const Icon(Icons.arrow_back),
                color: Colors.black45,
                onPressed: () async {
                  String test = 'test';
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage())//로그인 페이지로 이동
                  );
                },
              );
            },
          ),
          title: Text(widget.title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _buildBody(),


      ),
    );
  }
}