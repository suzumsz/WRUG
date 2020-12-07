import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(AccountPage());
}

class AccountPage extends StatelessWidget {

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
      home: MyHomePage(title: '개인정보'),
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

  final _name = '도메인';
  final _phone = '010-0000-0000';
  final _birth = '961111';
  final _email = 'domain@domain.com';

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
                  trailing: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MyApp()));
                    },
                    child: Text('개인정보수정',
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
                              Icons.supervisor_account_rounded,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text('$_email',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)),
                          subtitle: Text('이메일',
                              style: TextStyle(
                                  color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ListTile(
                          leading: Icon(
                              Icons.account_circle,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: Text('$_name',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)),
                          subtitle: Text('이름',
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
                          title: Text('$_phone',
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
                          title: Text('$_birth',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)),
                          subtitle: Text('생일',
                              style: TextStyle(
                                  color: Colors.black26)),
                        ),
                        SizedBox(
                          height: 10.0,
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
          title: Text('개인 정보',
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

