import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheregoing/Details_page.dart';
import 'Details_page.dart';
import 'Check_page.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ReservationPage());
}

class ReservationPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  String name = '';
  String phone = '';
  String email = '';
  String date = '';
  String finalDate = '';
  int people = 0;
  String error = '';
  int totalMoney = 0;
  String Money = '';

  final formatCurrency = new NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('$error입력해주세요'),
          );
        }
    );
  }

  void _showDatePicker() {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
      builder: (BuildContext context, Widget child){
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    selectedDate.then((dateTime) {
      date = '$dateTime';
      var cutOut = date.split(' ');
      finalDate = cutOut[0];
      print('선택: $finalDate');
    });
  }

  void _checkPeople(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoButton(
                  child: Text('닫기', style:TextStyle(color: Colors.red),textAlign: TextAlign.right,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.symmetric(
                    //horizontal: 16.0,
                    //vertical: 5.0,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 170,
                        child: CupertinoPicker(
                          itemExtent: 32,
                          onSelectedItemChanged: (int index){
                            people = index+1;
                            totalMoney = people*16000;
                            Money = (formatCurrency.format(totalMoney)).toString();
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
                    leading: Image.network("https://images.unsplash.com/photo-1595445364671-15205e6c380c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=764&q=80", scale: 1,),
                    title: Text('체험마을 이름', style: TextStyle(fontSize: 30),),
                    subtitle: Text('체험마을 주소 ex) 강원도 창원 어디어디',style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: 370,
              height: 560,
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      leading: Icon(
                          Icons.account_circle,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('문우석',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54)),
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
                      leading: Icon(
                          Icons.alternate_email,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('qwer12@naver.com',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54)),
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
                      leading: Icon(
                          Icons.phone,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('010-1234-5678',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54)),
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
                      leading: Icon(
                          Icons.supervisor_account_rounded,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('$people명',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54)),
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
                      leading: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('$finalDate',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54)),
                      subtitle: Text('예약날짜'),
                      trailing: RaisedButton(
                        onPressed: _showDatePicker,
                        child: const Text('예약날짜 선택하기',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),),
                        textColor: Colors.white,
                        color: Color.fromRGBO(168, 114, 207, 1),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                      leading: Icon(
                          Icons.phone,
                          color: Color.fromRGBO(137, 71, 184, 1)),
                      title: Text('010-1234-5678',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54)),
                      subtitle: Text('핸드폰'),
                    ),
                  ],
                ),
              )
          ),
          Container(
            height: 20,
          ),
          Container(
            //margin: const EdgeInsets.only(top: 16.0),
            padding: const EdgeInsets.all(8.0),
            width:350,
            height: 75,
            //alignment: Alignment.topCenter,
            child: RaisedButton(
              onPressed: () {
                if (people == 0){
                  print('인원을 선택해주세요');
                  error = '인원을 ';
                  _showDialog();
                } else if (finalDate == ''){
                  print('날짜를 선택해주세요');
                  error = '날짜를 ';
                  _showDialog();
                }else {
                  String test = 'test';
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          CheckPage()) //로그인 페이지로 이동
                  );
                  return;
                }
                print(name);
                print(phone);
                print(email);


              },
              child:
              Text('$Money원 결제하기',
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
                      MaterialPageRoute(builder: (context) => DetailsPage())//로그인 페이지로 이동
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
