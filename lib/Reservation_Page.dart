import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheregoing/Details_page.dart';
import 'Details_page.dart';
import 'Check_page.dart';
import 'Login_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthService()),
      ],
      child: ReservationPage(),
    ),
  );
}

DateTime _selectedTime;
int _people = 0;
String _userName;
String _userPhone;
String _userEmail;
String _townName;
String _townAddress;

class ReservationPage extends StatelessWidget {
  //StatefulWidget
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
      home: MyHomePage(title: '예약하기'),
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
  String name;
  String phone;
  String email;
  String date = '';
  String finalDate = '';
  int people = 0;
  String error = '';
  int totalMoney = 0;
  String Money = '';

  final formatCurrency = new NumberFormat.simpleCurrency(
      locale: "ko_KR", name: "", decimalDigits: 0);

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference Reservation =
      FirebaseFirestore.instance.collection('Reservation');

  Future<void> _inputUser() {
    return Reservation.doc('$_userEmail')
        .set({
          'email': '$_userEmail',
          'name': '$_userName',
          'phone': '$_userPhone',
          'date': '$_selectedTime',
          'people': '$_people',
        })
        .then((value) => print("Reservation Added"))
        .catchError((error) => print('Failed to add user: $error'));
  }

  void _AlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: new Text("'" + '$_townName' + "'" + " 예약이 완료되었습니다."),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("확인",
                      style: TextStyle(
                          fontSize: 15,
                          color: PrimaryColor,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckPage()) //로그인 페이지로 이동
                        );
                  },
                ),
              ]);
        });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$error입력해주세요'),
          );
        });
  }

  DateTime datePickter() {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), // 초깃값
      firstDate: DateTime(2018), // 시작일
      lastDate: DateTime(2030), // 마지막일
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(), // 다크테마
          child: child,
        );
      },
    );
    selectedDate.then((dateTime) {
      setState(() {
        _selectedTime = dateTime;
        print('날짜 선택 : ' + _selectedTime.toString());
        return _selectedTime;
      });
    });
    return null;
  }

  void _checkPeople() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 170,
                        child: CupertinoPicker(
                          itemExtent: 32,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              _people = index + 1;
                              totalMoney = _people * 16000;
                              Money = (formatCurrency.format(totalMoney))
                                  .toString();
                            });
                          },
                          children: <Widget>[
                            Center(child: Text('1명')),
                            Center(child: Text('2명')),
                            Center(child: Text('3명')),
                            Center(child: Text('4명')),
                            Center(child: Text('5명')),
                            Center(child: Text('6명')),
                            Center(child: Text('7명')),
                            Center(child: Text('8명')),
                            Center(child: Text('9명')),
                            Center(child: Text('10명')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        children: <Widget>[
          Container(
            width: 370,
            height: 100,
            child: Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      "https://images.unsplash.com/photo-1595445364671-15205e6c380c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=764&q=80",
                      scale: 1,
                    ),
                    title: Text(
                      '$_townName',
                      style: TextStyle(fontSize: 29),
                    ),
                    subtitle: Text(
                      ' ' + '$_townAddress',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: 370,
              height: 474,
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('$_userName',
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)),
                      subtitle: Text('예약자 이름'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(height: 1.0),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      leading: Icon(Icons.alternate_email,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('$_userEmail',
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)),
                      subtitle: Text('이메일'),
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
                      title: Text('$_userPhone',
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)),
                      subtitle: Text('핸드폰'),
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
                      title: Text(_people == null ? '0명' : '$_people명',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      subtitle: Text('인원'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: _checkPeople,
                      ),
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
                      title: Text(
                          DateFormat('MM월 dd일').format(_selectedTime == null
                              ? DateTime.now()
                              : _selectedTime),
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      subtitle: Text('예약날짜'),
                      trailing: RaisedButton(
                        onPressed: datePickter,
                        child: const Text(
                          '예약날짜선택',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: Colors.white,
                        color: Color.fromRGBO(168, 114, 207, 1),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(height: 1.0),
                  ],
                ),
              )),
          Container(
            height: 20,
          ),
          Container(
            //margin: const EdgeInsets.only(top: 16.0),
            padding: const EdgeInsets.all(8.0),
            width: 350,
            height: 75,
            //alignment: Alignment.topCenter,
            child: RaisedButton(
              onPressed: () {
                if (_people == 0) {
                  print('인원을 선택해주세요');
                  error = '인원을 ';
                  _showDialog();
                } else if (_selectedTime == null) {
                  print('날짜를 선택해주세요');
                  error = '날짜를 ';
                  _showDialog();
                } else {
                  String test = 'test';
                  _inputUser();
                  context.read<FirebaseAuthService>().incrementPeople(_people);
                  context
                      .read<FirebaseAuthService>()
                      .incrementDate(_selectedTime);
                  _people = 0;
                  _selectedTime = DateTime.now();

                  _AlertDialog();
                  return;
                }
                print(name);
                print(phone);
                print(email);
              },
              child: Text(
                '$Money원 결제하기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              textColor: Colors.white,
              color: Color.fromRGBO(168, 114, 207, 1),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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

  @override
  Widget build(BuildContext context) {
    //_getDB(1);
    _userName = context.watch<FirebaseAuthService>().userName;
    print(_userName);
    _userPhone = context.watch<FirebaseAuthService>().userPhone;
    print(_userPhone);
    _userEmail = context.watch<FirebaseAuthService>().loginEmail;
    print(_userEmail);
    _townName = context.watch<FirebaseAuthService>().townName;
    _townAddress = context.watch<FirebaseAuthService>().townAddress;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(168, 114, 207, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black45,
                onPressed: () async {
                  String test = 'test';
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage()) //로그인 페이지로 이동
                      );
                },
              );
            },
          ),
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 19, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _buildBody(),
      ),
    );
  }
}
