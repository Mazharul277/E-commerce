import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/PRODUCT/categories.dart';
import 'package:e_commerce/E-Com/cart.dart';
import 'package:e_commerce/UI/PROFILE/profile.dart';
import 'package:e_commerce/configs.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final List<Widget> _tabItems = [All_Pages(), Cart(), Profile()];
  int _activePage = 0;

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: backColor,
        height: MediaQuery.of(context).size.height * 0.075,
        color: colors,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home,color: Color(0xFFffffff),),
          Icon(Icons.add_shopping_cart,color: Color(0xFFffffff),),
          Icon(Icons.account_circle_outlined,color: Color(0xFFffffff),),
        ],
        onTap: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      body: _tabItems[_activePage],
    );
  }
}
