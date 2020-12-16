import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login_page.dart';
import 'Reservation_Page.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthService()),
      ],
      child: CheckPage(),
    ),
  );
}

String _userName;
String _userEmail;
String _userPhone;
String _userPeople;
String _userDate;

class user {
  String name;
  String email;
  String phone;

  user(this.name, this.email, this.phone);
}

class res {
  String date;
  String people;

  res(this.date, this.people);
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final _currentUser = FirebaseAuth.instance.currentUser;
var _todoController = TextEditingController();

// ignore: deprecated_member_use
final _firestore = Firestore.instance;

class CheckPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '예약확인'),
    );
  }
}

// 사용자 DB
Widget _buildItemWidget(DocumentSnapshot docs, int i) {
  final users = user(docs['name'], docs['email'], docs['phone']);

  user(users.name, users.email, users.phone);

  switch (i) {
    case 1:
      {
        return Text(
          users.name,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
          textAlign: TextAlign.left,
        );
      }
      break;
    case 2:
      {
        return Text(
          users.email,
          style: TextStyle(
            color: Colors.black26,
          ),
          textAlign: TextAlign.left,
        );
      }
      break;
    case 3:
      {
        return Text(
          users.phone,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
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
        return Row(children: [Expanded(child: _buildItemWidget(documents, i))]);
      });
}

// 사용자 예약 변경 사항 DB - 날짜 / 인원
Widget _buildItemDate(DocumentSnapshot doc, int i) {
  final Reservation = res(doc['date'], doc['people']);

  res(Reservation.date, Reservation.people);

  switch (i) {
    case 1:
      {
        return Text(
          Reservation.date,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
          textAlign: TextAlign.left,
        );
      }
      break;
    case 2:
      {
        return Text(
          Reservation.people + '명',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
          textAlign: TextAlign.left,
        );
      }
      break;
    default:
  }
}

Widget _resDB(int i) {
  return StreamBuilder<DocumentSnapshot>(
      stream: _firestore
          .collection("Reservation")
          .doc(_currentUser.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final documents = snapshot.data;
        return Container(child: _buildItemDate(documents, i));
      });
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
  final ScrollController _scrollController = ScrollController();

  Widget _buildBody() {
    return ListView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        children: <Widget>[
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined,
                      size: 50, color: Colors.black54),
                  title: Text('$_userName'),
                  subtitle: Text('$_userEmail'),
                  trailing: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReservationPage()));
                    },
                    child: Text('예약정보수정', style: TextStyle(fontSize: 13)),
                    textColor: Colors.white,
                    color: Color.fromRGBO(168, 114, 207, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 370,
                  height: 480,
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text(_userName),
                          subtitle: Text('예약자 이름',
                              style: TextStyle(color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(height: 1.0),
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.phone,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text(_userPhone),
                          subtitle: Text('핸드폰',
                              style: TextStyle(color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(height: 1.0),
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_today,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text(_userDate.substring(0, 10)),
                          /*Text('$date',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),*/
                          subtitle: Text('날짜',
                              style: TextStyle(color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(height: 1.0),
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.supervisor_account_rounded,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text('$_userPeople명'),
                          /*Text('4명',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),*/
                          subtitle: Text('인원',
                              style: TextStyle(color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(height: 1.0),
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.check,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text('결제완료',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                          subtitle: Text('결제여부',
                              style: TextStyle(color: Colors.black26)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    _userName = context.watch<FirebaseAuthService>().userName;
    _userEmail = context.watch<FirebaseAuthService>().loginEmail;
    _userPhone = context.watch<FirebaseAuthService>().userPhone;
    _userDate = context.watch<FirebaseAuthService>().userDate;
    _userPeople = context.watch<FirebaseAuthService>().userPeople;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('예약 확인',
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
        body: _buildBody(),
      ),
    );
  }
}
