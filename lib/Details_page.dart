import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'Login_page.dart';
import 'Reservation_Page.dart';
import 'main.dart';
import 'package:badges/badges.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthService()),
      ],
      child: DetailsPage(),
    ),
  );
}

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPage createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  final ScrollController _scrollController = ScrollController();

  String name;
  String address;

  Swiper imageSlider(context) {
    //NETWork image 캐쉬
    return new Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          "https://images.unsplash.com/photo-1595445364671-15205e6c380c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=764&q=80",
          fit: BoxFit.fitHeight,
        );
      },
      itemCount: 10,
      viewportFraction: 0.8,
      scale: 0.9,
    );
  }

  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  void _LoginError() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 후 이용해주세요'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var _loginCheck = context.watch<FirebaseAuthService>().loginEmail;
    final _firestore = Firestore.instance;

    Future<String> data2() async {
      var data1 = (await Firestore.instance
              .collection('town')
              .document('A7t9UCR2cqUzV8GLvUDj')
              .get())
          .data()
          .toString();
      name = data1.substring(7, 16).toString();
      address = data1.substring(28, 50).toString();
      return data1;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('체험 마을 상세보기',
                  style: TextStyle(fontSize: 19, color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  color: Colors.black45,
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Padding(
                padding: EdgeInsets.all(15.0),
                child: ListView(children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: 250,
                        height: 50,
                        child: FutureBuilder(
                          future: data2(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            String townStory = snapshot.data.toString();
                            return Text(
                              '' + townStory.substring(7, 16),
                              style: TextStyle(
                                  fontSize: 29, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text(
                          '예약하기',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () {
                          if (_loginCheck != null) {
                            context
                                .read<FirebaseAuthService>()
                                .incrementTownName(name);
                            context
                                .read<FirebaseAuthService>()
                                .incrementTownAddress(address);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReservationPage()));
                          } else {
                            _LoginError();
                          }
                        },
                        color: PrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 200.0,
                    child: FutureBuilder(
                      future: data2(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        String townStory = snapshot.data.toString();
                        return Text(
                          townStory.substring(60, 85) +
                              '\n' +
                              townStory.substring(85, 110) +
                              '\n' +
                              townStory.substring(110, 135),
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: 320.0,
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Color.fromRGBO(137, 71, 184, 1),
                      ),
                      FutureBuilder(
                        future: data2(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          String townStory = snapshot.data.toString();
                          return Text(
                            townStory.substring(28, 50),
                            style: TextStyle(
                                color: Color.fromRGBO(137, 71, 184, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          );
                        },
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    constraints: BoxConstraints.expand(
                      height: 300,
                    ),
                    child: imageSlider(context),
                  ),
                ]))));
  }
}
