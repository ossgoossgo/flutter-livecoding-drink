import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatefulWidget {
  String bgTag;
  String drinkTag;
  String waveTag;

  DetailPage({Key key, this.bgTag, this.drinkTag, this.waveTag})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isShow = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isShow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          _buildTopBg(),
          Align(
            alignment: Alignment(1, -0.5),
            child: FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: FittedBox(
                child: Container(
                  //color: Colors.red,
                  child: Hero(
                    tag: widget.waveTag,
                    child: Transform.translate(
                      offset: Offset(20, 0),
                      child: Image.asset("assets/images/wave.png",
                          fit: BoxFit.contain,
                          // width: 240,
                          // height: 240,
                          color: Colors.white.withOpacity(0.4)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTopNavigation(),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: FractionalOffset(0.22, 0.35),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.8,
                      child: Hero(
                        tag: widget.drinkTag,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(150, 255, 178, 49),
                                blurRadius: ScreenUtil().setWidth(30),
                                offset: Offset(ScreenUtil().setHeight(15),
                                    ScreenUtil().setWidth(10)))
                          ]),
                          child: Image.asset(
                            "assets/images/walkBrothers.png",
                            fit: BoxFit.contain,
                            width: 350,
                            height: 350,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: _isShow ? 1000 : 10),
                    opacity: _isShow ? 1 : 0,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        children: <Widget>[
                          Text("High Gravity Kombucha",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w800)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "A clean, probiotic alternative to\nbeer,wine,and spirits...",
                              style: TextStyle(
                                  height: 2.0,
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: _buildAmountAndPrice(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  _buildAmountAndPrice() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: _isShow ? 1000 : 10),
      opacity: _isShow ? 1 : 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.grey.shade300))),
            child: Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      color: Colors.grey,
                      size: 20,
                    )),
                Text("1",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.w700)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: ScreenUtil().setSp(20),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(80, 254, 168, 2),
                      blurRadius: 15,
                      offset: Offset(10, 10)),
                ],
                color: Color.fromARGB(255, 254, 168, 2),
                borderRadius: BorderRadius.circular(20)),
            child: Text("\$9",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(25),
                    fontWeight: FontWeight.w700)),
          )
        ],
      ),
    );
  }

  _buildTopBg() {
    return Hero(
      tag: widget.bgTag,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 183, 82),
                  Color.fromARGB(255, 255, 228, 98),
                ]),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
      ),
    );
  }

  _buildTopNavigation() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 20, right: 30),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  _isShow = false;
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            SizedBox(width: 10),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
