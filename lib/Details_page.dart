import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'Reservation_Page.dart';
import 'main.dart';
import 'package:badges/badges.dart';

void main() {
  runApp(DetailsPage());
}

class DetailsPage extends StatelessWidget {

  Swiper imageSlider(context){//NETWork image 캐쉬
    return new Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index){
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

  final _title = '체험마을 이름';
  final _story = '체험마을에 대한 설명\n저희 체험마을은 이런 곳 입니다.';
  final _location = '인천광역시 강화군 불은면 강화동로 416';

  static const PrimaryColor = Color.fromRGBO(168, 114, 207, 1);
  static const SubColor = Color.fromRGBO(241, 230, 250, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('체험 마을 상세보기',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black45,
                  icon: Icon(Icons.arrow_back)),
            ),
            body: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                    children: <Widget>[
                      ButtonBar(
                        children: <Widget> [
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 230,
                            child: Text('$_title', textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 30)),
                          ),
                          RaisedButton(
                            child: Text('예약하기', style: TextStyle(fontSize: 18),),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReservationPage()));
                            },
                            color: PrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 300.0,
                        child: Text('$_story', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                          width: 320,
                          child: Row(
                            children: <Widget> [
                              Icon(Icons.location_on, color: Color.fromRGBO(137,71,184,1),),
                              Text('$_location', style: TextStyle(color: Color.fromRGBO(137,71,184,1), fontWeight: FontWeight.bold, fontSize: 16),)
                            ],
                          )
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Chip(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PrimaryColor,
                            label: Text('체험마을', style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Chip(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PrimaryColor,
                            label: Text('인천광역시', style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Chip(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PrimaryColor,
                            label: Text('인천체험마을', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Chip(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PrimaryColor,
                            label: Text('강화도', style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Chip(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PrimaryColor,
                            label: Text('감자캐기', style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Chip(
                            padding: EdgeInsets.all(0),
                            backgroundColor: PrimaryColor,
                            label: Text('감자', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        constraints: BoxConstraints.expand(
                          height: 300,
                        ),child: imageSlider(context),
                      ),
                    ]
                )
            )
        )
    );
  }
}
