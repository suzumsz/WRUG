import 'package:flutter/material.dart';
import 'Join_page.dart';
import 'Login_page.dart';
import 'Check_page.dart';
import 'Account_Page.dart';
import 'Details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class user {
  String name, email, phone;
  user(this.name, this.email, this.phone);
}

class town {
  String name, location, content;
  town(this.name, this.location, this.content);
}

class town_a {
  String name, location, content;
  town_a(this.name, this.location, this.content);
}

class town_b {
  String location, name, content;
  town_b(this.name, this.location, this.content);
}

class town_c {
  String location, name, content;
  town_c(this.name, this.location, this.content);
}

class town_d {
  String location, name, content;
  town_d(this.name, this.location, this.content);
}

String _email;
String _phone;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.purple,
      ),
      home: MainPage(title: '메인 페이지'),
    );
  }
}

class AppState {
  bool loading;
  FirebaseUser user;
  AppState(this.loading, this.user);
}

class MainPage extends StatefulWidget {
  //StatefullWidget으로 바꾸기
  String title;
  MainPage({Key key, this.title}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  String _name;
  var _documents;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus(); // 퍼미션 검사
  }

  // 퍼미션 검사
  void _listenForPermissionStatus() async {
    final isPermissionStatusGranted = await _requestPermissions();
  }

  // 퍼미션 검사
  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    // 로그인 체크
    String loginEmail = context.watch<FirebaseAuthService>().loginEmail;
    String _userName = context.watch<FirebaseAuthService>().userName;

    var _loginCheck = context.watch<FirebaseAuthService>().loginEmail;
    var _ResCheck = context.watch<FirebaseAuthService>().userDate;

    void _moreButton() {
      if (_loginCheck != null) {}
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailsPage()));
    }

    Widget _buildItemWidget(DocumentSnapshot doc) {
      final towns = town(doc['name'], doc['location'], doc['content']);
      final t = town_a(doc['name'], doc['location'], doc['content']);
      final o = town_b(doc['name'], doc['location'], doc['content']);
      final w = town_c(doc['name'], doc['location'], doc['content']);
      final n = town_d(doc['name'], doc['location'], doc['content']);
      return Card(
        child: Column(children: [
          ListTile(
            title: Text(
              '\n' + towns.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Wrap(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 18,
                      color: Color.fromRGBO(137, 71, 184, 1),
                    ),
                    Padding(
                      child: Text(
                        towns.location,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(137, 71, 184, 1),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 5),
                    ),
                  ],
                )),
            trailing: TextButton(
              onPressed: _moreButton,
              child: const Text(
                '더보기',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              towns.content + '\n',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ]),
      );
    }

    Widget Signin() {
      return new DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 71, 184, 1),
        ),
        child: Text(
          '\n\n로그인 후 예약 가능합니다.',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
    }

    // 메인페이지 버튼
    Widget mainBtn() {
      return new ListTile(
        leading: Icon(Icons.home, color: Colors.white),
        title: Text(
          '홈',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      );
    }

    // 개인정보 버튼
    Widget accountBtn() {
      return new ListTile(
        leading: Icon(Icons.account_circle, color: Colors.white),
        title: Text(
          '내 정보',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountPage()));
        },
      );
    }

    // 예약확인 버튼
    Widget fact_check() {
      return new ListTile(
        leading: Icon(Icons.fact_check, color: Colors.white),
        title: Text(
          '예약 확인',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (_ResCheck != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CheckPage()));
          } else {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('예약 후에 이용해주세요'),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("확인",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: PrimaryColor,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ]);
                });
          }
        },
      );
    }

    // 빈공간 채우기
    Widget box(int i) {
      return new SizedBox(height: MediaQuery.of(context).size.height - 137 - i);
    }

    // 로그인버튼
    Widget loginBtn() {
      return new ListTile(
        leading: Icon(Icons.login, color: Colors.white),
        title: Text(
          '로그인',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    }

    // 회원가입 버튼
    Widget registerBtn() {
      return new ListTile(
        leading: Icon(Icons.person, color: Colors.white),
        title: Text(
          '회원가입',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => JoinPage()));
        },
      );
    }

    // 로그아웃 버튼
    Widget logoutBtn() {
      return new ListTile(
        leading: Icon(Icons.logout, color: Colors.white),
        title: Text(
          '로그아웃',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          // 로그아웃 처리
          await _auth.signOut();
          context.read<FirebaseAuthService>().updateLoggedOut();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Stack(
            children: <Widget>[
              new Center(
                  child: new Column(
                children: <Widget>[],
              )),
              Positioned(
                //left: 0,
                //top: 20,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
        key: scaffoldKey,
        drawer: Drawer(
          child: Container(
            //height: MediaQuery.of(context).size.height - 137,
            color: Color.fromRGBO(137, 71, 184, 1),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                //if (_loginCheck == null) Signin() else _getDB(1),

                if (_userName == null)
                  Signin()
                else
                  Text(
                    '\n\n\n   ' + _userName + '님 환영합니다! \n\n',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),

                mainBtn(),

                if (_loginCheck != null) accountBtn() else registerBtn(),

                // 로그인 여부에 따른 예약확인 유무
                if (_loginCheck != null) fact_check(),

                //if (_loginCheck != null) box(250) else box(250),

                // 로그인 전
                if (_loginCheck == null) loginBtn() else logoutBtn(),
              ],
            ),
          ),
        ),
        //여기서부터 body
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                child: Wrap(
                  children: List<Widget>.generate(
                    1,
                    (int index) {
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: PrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: PrimaryColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: PrimaryColor,
                                ),
                                hintText: '체험마을을 검색해보세요.'),
                            onSaved: (String value) {
                              print('Value for field $index saved as "$value"');
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    DefaultTabController(
                        length: 5,
                        child: Column(children: <Widget>[
                          TabBar(
                            indicator: BoxDecoration(
                              color: PrimaryColor,
                            ),
                            labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: PrimaryColor,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Container(
                                width: 90,
                                height: 80,
                                child: Tab(
                                  child: Text(
                                    "수도권",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 90,
                                height: 80,
                                child: Tab(
                                  child: Text(
                                    "강원도",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 90,
                                height: 80,
                                child: Tab(
                                  child: Text(
                                    "전라도",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 90,
                                height: 80,
                                child: Tab(
                                  child: Text(
                                    "충청도",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 90,
                                height: 80,
                                child: Tab(
                                  child: Text(
                                    "경상도",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height - (250),
                              margin: const EdgeInsets.only(top: 10),

                              //height of TabBarView

                              child: TabBarView(children: <Widget>[
                                //수도권
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Row(children: [
                                      Expanded(
                                        child: ListView(
                                          children: documents
                                              .map((doc) =>
                                                  _buildItemWidget(doc))
                                              .toList(),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                                //강원도
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_a')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Row(children: [
                                      Expanded(
                                        child: ListView(
                                          children: documents
                                              .map((doc) =>
                                                  _buildItemWidget(doc))
                                              .toList(),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                                //전라도
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_b')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Row(children: [
                                      Expanded(
                                        child: ListView(
                                          children: documents
                                              .map((doc) =>
                                                  _buildItemWidget(doc))
                                              .toList(),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                                //충청도
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_c')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Row(children: [
                                      Expanded(
                                        child: ListView(
                                          children: documents
                                              .map((doc) =>
                                                  _buildItemWidget(doc))
                                              .toList(),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                                //경상도
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_d')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Row(children: [
                                      Expanded(
                                        child: ListView(
                                          children: documents
                                              .map((doc) =>
                                                  _buildItemWidget(doc))
                                              .toList(),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                              ]))
                        ])),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
