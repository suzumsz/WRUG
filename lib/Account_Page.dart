import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Login_page.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class user {
  String name;
  String email;
  String phone;
  String birth;
  user(this.name, this.email, this.phone, this.birth);
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
      home: MyHomePage(title: '내 정보'),
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
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _firestore = Firestore.instance;

  final ScrollController _scrollController = ScrollController();

  String _name;
  String _phone;
  String _birth;
  String _email;

  Widget _buildItemWidget(DocumentSnapshot doc, int i) {
    final users = user(doc['name'], doc['email'], doc['phone'], doc['birth']);

    user(users.name, users.email, users.phone, users.birth);

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
              color: Colors.black54,
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
      case 4:
        {
          return Text(
            users.birth,
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

    /*_name = users.name;
    _phone = users.phone;
    _birth = users.birth;
    _email = users.email; */
  }

  Widget _getDB(int i) {
    return StreamBuilder<DocumentSnapshot>(
        stream:
            _firestore.collection("user").doc(_currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data;
          return Expanded(child: _buildItemWidget(documents, i));
        });
  }

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
                          leading: Icon(Icons.supervisor_account_rounded,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: _getDB(2),
                          /* title: Text('$_email',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)), */
                          subtitle: Text('이메일',
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
                          leading: Icon(Icons.account_circle,
                              color: Color.fromRGBO(137, 71, 184, 1)),
                          title: _getDB(1),
                          /* title: Text('$_name',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)), */
                          subtitle: Text('이름',
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
                          title: _getDB(3),
                          /*title: Text('$_phone',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)), */
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
                          title: _getDB(4),
                          /*title: Text('$_birth',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54)),*/
                          subtitle: Text('생일',
                              style: TextStyle(color: Colors.black26)),
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
        ]);
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
          title: Text('내 정보',
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
