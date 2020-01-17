import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:device_simulator/device_simulator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _categoryList = ["Tea", "Wine", "Beer", "Milk", "Juice"];
  int _categorySelectedIdx = 0;
  PageController _pageController = PageController(viewportFraction: 0.75);
  double _pageControllerPage = 0.0;

  @override
  Widget build(BuildContext context) {
//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 320, height: 1336 / 2);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
                color: Color.fromARGB(255, 255, 248, 237)),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _buildSearchBar(),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                Expanded(flex: 2, child: _buildUserProfile()),
                _buildCategoryList(),
                Expanded(flex: 8, child: _buildMenu()),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                )
              ],
            )
          ],
        ));
  }

  _getScale(int idx) {
    double scale = 1 - (_pageControllerPage - idx).abs();
    return scale < 0.9 ? 0.9 : scale;
  }

  _buildSearchBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(25),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          child: TextField(
              style: TextStyle(fontSize: 25),
              cursorColor: Color.fromARGB(255, 254, 182, 81),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "What would you like?",
                fillColor: Colors.white,
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
                suffixIcon: Icon(Icons.search,
                    color: Color.fromARGB(255, 254, 182, 81)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              )),
        ),
      ),
    );
  }

  _buildUserProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      //height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Welcom back",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400)),
              Text("Charlize Wong",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(22),
                    fontWeight: FontWeight.w700,
                  ))
            ],
          ),
          ClipOval(
            child: Container(
              color: Colors.grey.shade200,
              width: ScreenUtil().setWidth(70),
              height: ScreenUtil().setWidth(70),
              child: Image.network(
                  "https://image.freepik.com/free-photo/beautiful-girl-bed_144627-10750.jpg",
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }

  _buildCategoryList() {
    return Container(
        height: ScreenUtil().setHeight(50),
        child: ListView.builder(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
            ),
            scrollDirection: Axis.horizontal,
            itemCount: _categoryList.length,
            itemExtent: 90.0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _categorySelectedIdx = index;
                  setState(() {});
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(_categoryList[index],
                      style: TextStyle(
                          fontSize: _categorySelectedIdx == index
                              ? ScreenUtil().setSp(25)
                              : ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w700,
                          color: _categorySelectedIdx == index
                              ? Color.fromARGB(255, 254, 182, 81)
                              : Color.fromARGB(255, 255, 204, 110))),
                ),
              );
            }));
  }

  _buildMenu() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
      //height: 480,
      child: NotificationListener<ScrollNotification>(
        onNotification: (_) {
          setState(() {
            _pageControllerPage = _pageController.page;
            debugPrint("$_pageControllerPage");
          });
          return true;
        },
        child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, idx) {
              return Transform.scale(
                scale: _getScale(idx),
                child: Container(
                  //color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ClipRect(
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: "baTag_$idx",
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 255, 183, 82),
                                      Color.fromARGB(255, 255, 228, 98),
                                    ])),
                          ),
                        ),
                        Container(
                          alignment: FractionalOffset(0.2, 0),
                          child: FractionallySizedBox(
                            alignment: Alignment.topLeft,
                            heightFactor: 0.5,
                            widthFactor: 0.5,
                            child: FittedBox(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Traditional\nKombucha",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(10),
                                    ),
                                    Text("\$9",
                                        style: TextStyle(
                                            color: Colors.white,
                                          fontSize: ScreenUtil().setSp(15),
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Transform.translate(
                            offset: Offset(20, 10),
                            child: FractionallySizedBox(
                              widthFactor: 0.6,
                              heightFactor: 0.6,
                              child: Hero(
                                tag: "waveTag_$idx",
                                child: Image.asset("assets/images/wave.png",
                                    fit: BoxFit.contain,
                                    width: 200,
                                    height: 200,
                                    color: Colors.white.withOpacity(0.2)),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Transform.translate(
                              offset: Offset(0, 30),
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                heightFactor: 0.6,
                                child: Hero(
                                  tag: "drink_$idx",
                                  child: Image.asset(
                                    "assets/images/walkBrothers.png",
                                    fit: BoxFit.contain,
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                              )),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (context, _, __) {
                                        return DeviceSimulator(
                                          child: DetailPage(
                                            waveTag: "waveTag_$idx",
                                            bgTag: "baTag_$idx",
                                            drinkTag: "drink_$idx",
                                          ),
                                        );
                                      }));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
