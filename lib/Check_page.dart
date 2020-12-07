import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(CheckPage());
}

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
        leading: Icon(
            Icons.account_circle_outlined,
            size: 50,
            color: Colors.black54),
        title: Text('김수정',
            style: TextStyle(
                fontSize: 18)),
        subtitle: Text('tnwjd@google.com',
            style: TextStyle(
                color: Colors.black26)),
        trailing: RaisedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    MyApp()));
          },
          child: Text('예약정보수정',
              style: TextStyle(
                  fontSize: 13)),
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
                leading: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(137, 71, 184, 1)),
                title: Text('한송희',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54)),
                subtitle: Text('예약자 이름',
                    style: TextStyle(
                        color: Colors.black26)),
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
                subtitle: Text('핸드폰',
                    style: TextStyle(
                        color: Colors.black26)),
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
                title: Text('2020/10/30',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54)),
                subtitle: Text('날짜',
                    style: TextStyle(
                        color: Colors.black26)),
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
                title: Text('4명',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54)),
                subtitle: Text('인원',
                    style: TextStyle(
                        color: Colors.black26)),
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
                    Icons.check,
                    color: Color.fromRGBO(137, 71, 184, 1)),
                title: Text('결제완료',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54)),
                subtitle: Text('결제여부',
                    style: TextStyle(
                        color: Colors.black26)),
              ),
            ],
          ),
        ),
      ),
          Container(
          width: 370,
            height: 400,
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    leading: Icon(
                        Icons.map_outlined,
                        color: Color.fromRGBO(137, 71, 184, 1)),
                    title: Text('위치',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54)),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
    ),
    ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp()
                    )
                );
              },
              color: Colors.black45,
              icon: Icon(Icons.arrow_back)),
        ),
        body: _buildBody(),
      ),
    );
  }
}

