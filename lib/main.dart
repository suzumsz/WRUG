import 'package:flutter/material.dart';
import 'Join_page.dart';
import 'Login_page.dart';
import 'Check_page.dart';
import 'Account_Page.dart';
import 'Details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseAuth _auth = FirebaseAuth.instance;

final _id = 'abc@naver.com';
final name = 'abcde';
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

class AppState {
  bool loading;
  FirebaseUser user;
  AppState(this.loading, this.user);
}

class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String title;
  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  @override
  Widget build(BuildContext context) {
    // 로그인 된 경우 DrawerHeader
    Widget Login_done() {
      return new DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 71, 184, 1),
        ),
        child: Text(
          '\n$name\n$_id',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      );
    }

    // 로그인 된 경우 로그아웃 버튼 137
    Widget Login_dones() {
      return new ListTile(
        leading: Icon(Icons.logout),
        title: Text('로그아웃'),
        onTap: () {
          // 로그아웃 처리
          _auth.signOut();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      );
    }

    // 로그인 안 된 경우 DrawerHeader
    Widget Login_Signup() {
      return new DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 71, 184, 1),
        ),
        child: Text(
          '\n\n로그인 후 예약 가능합니다.',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      );
    }

    // 로그인 안 된 경우 로그인 버튼
    Widget Login_Signups() {
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

    // 회원가입
    Widget register() {
      return new ListTile(
        leading: Icon(Icons.person_add_alt, color: Colors.white),
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

    // 예약확인
    Widget fact_check() {
      return new ListTile(
        leading: Icon(Icons.fact_check),
        title: Text('예약확인'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckPage()));
        },
      );
    }

    // 개인정보
    Widget account() {
      return new ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('개인정보'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountPage()));
        },
      );
    }

    Widget box(int size) {
      return new SizedBox(
        height: MediaQuery.of(context).size.height - (137 + size),
      );
      // return new Container(
      //   height: 450,
      //   color: Colors.white,
      //   child:LayoutBuilder(
      //     builder: (BuildContext context, BoxConstraints constraints) {
      //       final localWidgetSize=Size(constraints.maxWidth, constraints.maxHeight);
      //       return Center(
      //           child: Text('this is container: ${localWidgetSize.height}')
      //       );
      //     },
      //   ),
      // );
    }

    Widget boxe() {
      return new SizedBox(height: 100);
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
              // 로그인 여부에 따른 DrawerHeader
              if (app.user == null) Login_Signup() else Login_done(),

              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  '메인페이지',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),

              // 로그인 여부에 따른 개인정보 유무
              if (app.user != null) account() else register(),

              // 로그인 여부에 따른 예약확인 유무
              if (app.user != null) fact_check() else boxe(),

              if (app.user != null) box(300) else box(350),

              // 로그인 했을 경우
              // if(app.user == null) Login_dones()
              // else Login_Signups(),

              // 로그인 전
              if (app.user == null) Login_Signups() else Login_dones(),
            ],
          ),
        ),
      ),
      //여기서부터 body
      body: Column(
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
                          height: 500,
                          margin: const EdgeInsets.only(top: 10),

                          //height of TabBarView

                          child: TabBarView(children: <Widget>[
                            new ListView(
                              //-------수도권
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '농사 체험',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '농사 체험',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //----------강원도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //---------전라도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //---------충청도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //--------경상도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]))
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class MyApp extends StatelessWidget {
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

class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String title;
  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  @override
  Widget build(BuildContext context) {
    // 로그인 된 경우 DrawerHeader
    Widget Login_done() {
      return new DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 71, 184, 1),
        ),
        child: Text(
          '\n$name\n$_id',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      );
    }

    // 로그인 된 경우 로그아웃 버튼
    Widget Login_dones() {
      return new ListTile(
        leading: Icon(Icons.logout),
        title: Text('로그아웃'),
        onTap: () {
          // 로그아웃 처리
          _auth.signOut();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
      );
    }

    // 로그인 안 된 경우 DrawerHeader
    Widget Login_Signup() {
      return new DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(137, 71, 184, 1),
        ),
        child: Text(
          '\n\n로그인 후 예약 가능합니다.',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      );
    }

    // 로그인 안 된 경우 로그인 버튼
    Widget Login_Signups() {
      return new ListTile(
        leading: Icon(Icons.login),
        title: Text('로그인'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    }

    // 회원가입
    Widget register() {
      return new ListTile(
        leading: Icon(Icons.person_add_alt),
        title: Text('회원가입'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => JoinPage()));
        },
      );
    }

    // 예약확인
    Widget fact_check() {
      return new ListTile(
        leading: Icon(Icons.fact_check),
        title: Text('예약확인'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckPage()));
        },
      );
    }

    // 개인정보
    Widget account() {
      return new ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('개인정보'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountPage()));
        },
      );
    }

    Widget box1() {
      return new SizedBox(
        height: 50.0,
      );
    }

    Widget box2() {
      return new SizedBox(
        height: 300.0,
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 로그인 여부에 따른 DrawerHeader
            if (app.user == null) Login_Signup() else Login_done(),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('메인페이지'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),

            // 로그인 여부에 따른 개인정보 유무
            if (app.user == null) account() else register(),

            // 로그인 여부에 따른 예약확인 유무
            if (app.user == null) fact_check() else box1(),

            box2(),

            // 로그인 했을 경우
            // if(app.user == null) Login_dones()
            // else Login_Signups(),

            // 로그인 전
            if (app.user == null) Login_Signups() else Login_dones(),
          ],
        ),
      ),
      //여기서부터 body
      body: Column(
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
                          height: 500,
                          margin: const EdgeInsets.only(top: 10),

                          //height of TabBarView

                          child: TabBarView(children: <Widget>[
                            new ListView(
                              //-------수도권
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '농사 체험',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '농사 체험',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //----------강원도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //---------전라도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //---------충청도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new ListView(
                              //--------경상도
                              children: <Widget>[
                                Container(
                                  height: 160,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              EdgeInsets.only(left: 15, top: 8),
                                          title: const Text(
                                            '두부 체험 마을',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Padding(
                                              padding: EdgeInsets.only(top: 10),
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
                                                        color: Color.fromRGBO(
                                                            137, 71, 184, 1),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsPage()));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]))
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//           Container(
//             margin: const EdgeInsets.only(right: 15, left: 15),
//             child: Column(
//               children: [
//                 DefaultTabController(
//                     length: 5,
//                     child: Column(children: <Widget>[
//                       TabBar(
//                         labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                         isScrollable: true,
//                         indicatorSize: TabBarIndicatorSize.label,
//                         indicatorColor: PrimaryColor,
//                         labelColor: Colors.black,
//                         unselectedLabelColor: Colors.black,
//                         tabs: [
//                           Container(
//                             width: 90,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: SubColor,
//                             ),
//                             child: Tab(
//                               child: Text(
//                                 "수도권",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 90,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: SubColor,
//                             ),
//                             child: Tab(
//                               child: Text(
//                                 "강원도",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 90,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: SubColor,
//                             ),
//                             child: Tab(
//                               child: Text(
//                                 "전라도",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 90,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: SubColor,
//                             ),
//                             child: Tab(
//                               child: Text(
//                                 "충청도",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 90,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: SubColor,
//                             ),
//                             child: Tab(
//                               child: Text(
//                                 "경상도",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                           height: 500,
//                           margin: const EdgeInsets.only(top: 10),
//
//                           //height of TabBarView
//
//                           child: TabBarView(children: <Widget>[
//                             new ListView(
//                               //-------수도권
//                               children: <Widget>[
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '농사 체험',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '두부 체험 마을',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '농사 체험',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '농사를 직접 체험해보며 농부가 흘리는 땀방울의 소중함을 느껴보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '두부 체험 마을',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             new ListView(
//                               //----------강원도
//                               children: <Widget>[
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '두부 체험 마을',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             new ListView(
//                               //---------전라도
//                               children: <Widget>[
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '두부 체험 마을',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             new ListView(
//                               //---------충청도
//                               children: <Widget>[
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '두부 체험 마을',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             new ListView(
//                               //--------경상도
//                               children: <Widget>[
//                                 Container(
//                                   height: 160,
//                                   child: Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           contentPadding:
//                                           EdgeInsets.only(left: 15, top: 8),
//                                           title: const Text(
//                                             '두부 체험 마을',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Padding(
//                                               padding: EdgeInsets.only(top: 10),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 18,
//                                                     color: Color.fromRGBO(
//                                                         137, 71, 184, 1),
//                                                   ),
//                                                   Padding(
//                                                     child: Text(
//                                                       '$_location',
//                                                       style: TextStyle(
//                                                         fontSize: 13,
//                                                         color: Color.fromRGBO(
//                                                             137, 71, 184, 1),
//                                                       ),
//                                                     ),
//                                                     padding: EdgeInsets.only(
//                                                         left: 5),
//                                                   ),
//                                                 ],
//                                               )),
//                                           trailing: TextButton(
//                                             child: const Text(
//                                               '더보기',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           DetailsPage()));
//                                             },
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Text(
//                                             '콩을 갈아 직접 두부를 만들어보고 만든 두부로 음식 또한 맛볼 수 있는 이색 체험을 경험해보세요!',
//                                             style: TextStyle(
//                                               color:
//                                               Colors.black.withOpacity(0.6),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ]))
//                     ])),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }*/
