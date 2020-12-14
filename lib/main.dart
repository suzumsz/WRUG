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
  String name;
  String email;
  String phone;

  user(this.name, this.email, this.phone);
}

class town {
  String name;
  String location;
  town(this.name, this.location);
}

class town_a {
  String name;
  String location;
  town_a(this.name, this.location);
}

class town_b {
  String location;
  String name;
  town_b(this.name, this.location);
}

class town_c {
  String location;
  String name;
  town_c(this.name, this.location);
}

class town_d {
  String location;
  String name;
  town_d(this.name, this.location);
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final _currentUser = FirebaseAuth.instance.currentUser;
final _firestore = Firestore.instance;
//provider패키지 이용
String _email;
String _name;
String _phone;
final _location = '인천광역시 강화군 불은면 강화동로 416';
final app = AppState(false, null);

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

Widget _buildItemWidget(DocumentSnapshot docs, int i) {
  final users = user(docs['name'], docs['email'], docs['phone']);

  user(users.name, users.email, users.phone);

  switch (i) {
    case 1:
      {
        _name = users.name.toString();
        _email = users.email.toString();
        _phone = users.phone.toString();
        return Text(
          '\n\n\n   ' + users.name + '님 환영합니다! \n\n',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        );
      }
      break;

    default:
  }
}

Widget _getDB(int i) {
  return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection("user").doc(_currentUser.email).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final documents = snapshot.data;
        return Expanded(child: _buildItemWidget(documents, i));
      });
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
  var scaffoldKey = GlobalKey<ScaffoldState>();

  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  @override
  Widget build(BuildContext context) {
    var _loginCheck = context.watch<FirebaseAuthService>().count;
    print("loginCheck: $_loginCheck");
    void _moreButton() {
      if (_loginCheck != null) {
        context.read<FirebaseAuthService>().incrementName(_name);
        context.read<FirebaseAuthService>().incrementPhone(_phone);
        context.read<FirebaseAuthService>().increment(_email);
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailsPage()));
    }

    Widget _buildItemWidget(DocumentSnapshot doc) {
      final towns = town(doc['name'], doc['location']);
      final t = town_a(doc['name'], doc['location']);
      final o = town_b(doc['name'], doc['location']);
      final w = town_c(doc['name'], doc['location']);
      final n = town_d(doc['name'], doc['location']);
      return ListTile(
        title: Text(
          towns.name,
        ),
        subtitle: Text(
          towns.location,
        ),
        trailing: TextButton(
          onPressed: _moreButton,
          child: const Text('더보기'),
        ),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckPage()));
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
        onTap: () {
          // 로그아웃 처리
          _auth.signOut();
          print(_currentUser);
          print(_currentUser.email);
          context.read<FirebaseAuthService>().decrement();
          context.read<FirebaseAuthService>().decrementDate();
          context.read<FirebaseAuthService>().decrementName();
          context.read<FirebaseAuthService>().decrementPeople();
          context.read<FirebaseAuthService>().decrementPhone();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      );
    }

    return Scaffold(
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
            height: MediaQuery.of(context).size.height - 137,
            color: Color.fromRGBO(137, 71, 184, 1),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                if (_loginCheck == null) Signin() else _getDB(1),

                mainBtn(),

                if (_loginCheck != null) accountBtn() else registerBtn(),

                // 로그인 여부에 따른 예약확인 유무
                if (_loginCheck != null) fact_check(),

                if (_loginCheck != null) box(250) else box(250),

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
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Expanded(
                                      child: ListView(
                                        children: documents
                                            .map((doc) => _buildItemWidget(doc))
                                            .toList(),
                                      ),
                                    );
                                  },
                                ),
                                /*new ListView(
                                  //-------수도권
                                  children: <Widget>[
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '농사 체험',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '두부 체험 마을',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '농사 체험',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '두부 체험 마을',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_a')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Expanded(
                                      child: ListView(
                                        children: documents
                                            .map((doc) => _buildItemWidget(doc))
                                            .toList(),
                                      ),
                                    );
                                  },
                                ),
                                /*  new ListView(
                                  //----------강원도
                                  children: <Widget>[
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '두부 체험 마을',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_b')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Expanded(
                                      child: ListView(
                                        children: documents
                                            .map((doc) => _buildItemWidget(doc))
                                            .toList(),
                                      ),
                                    );
                                  },
                                ),
                                /*new ListView(
                                  //---------전라도
                                  children: <Widget>[
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '두부 체험 마을',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_c')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Expanded(
                                      child: ListView(
                                        children: documents
                                            .map((doc) => _buildItemWidget(doc))
                                            .toList(),
                                      ),
                                    );
                                  },
                                ),
                                /*new ListView(
                                  //---------충청도
                                  children: <Widget>[
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '두부 체험 마을',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                new StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('town_d')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    final documents = snapshot.data.documents;
                                    return Expanded(
                                      child: ListView(
                                        children: documents
                                            .map((doc) => _buildItemWidget(doc))
                                            .toList(),
                                      ),
                                    );
                                  },
                                ),
                                /*new ListView(
                                  //--------경상도
                                  children: <Widget>[
                                    Container(
                                      height: 170,
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, top: 8),
                                              title: const Text(
                                                '두부 체험 마을',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                      Padding(
                                                        child: Text(
                                                          '$_location',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    137,
                                                                    71,
                                                                    184,
                                                                    1),
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                      ),
                                                    ],
                                                  )),
                                              trailing: TextButton(
                                                child: const Text(
                                                  '더보기',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onPressed: _moreButton,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
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
