import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/my_page.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/travel_page.dart';

const BAR_LIST = {
  "meun": [
    {"name": "首页", "icon": "Icons.home", "index": 0},
    {"name": "搜索", "icon": "Icons.search", "index": 1},
    {"name": "旅拍", "icon": "Icons.camera_alt", "index": 2},
    {"name": "我的", "icon": "Icons.account_circle", "index": 3}
  ]
};

const _defaultColor = Colors.grey;
const _activeColor = Colors.blue;

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigator createState() => _TabNavigator();
}

class _TabNavigator extends State<TabNavigator> {
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(
            leftHide: true,
          ),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: _items(context));
  }

  _items(BuildContext context) {
//    BottomNavModel bottomNavModel = BottomNavModel.fromJson(BAR_LIST);
    List<BottomNavigationBarItem> lists = new List();
//    bottomNavModel.data.forEach((model) {
//      lists.add(_bottomNavigationBarItem(context, model));
//    });

    lists.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          Icons.home,
          color: _activeColor,
        ),
        title: Text(
          "首页",
          style: TextStyle(
              color: _currentIndex != 0 ? _defaultColor : _activeColor),
        )));
    lists.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          Icons.search,
          color: _activeColor,
        ),
        title: Text(
          "搜索",
          style: TextStyle(
              color: _currentIndex != 1 ? _defaultColor : _activeColor),
        )));
    lists.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.camera_alt,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          Icons.camera_alt,
          color: _activeColor,
        ),
        title: Text(
          "旅拍",
          style: TextStyle(
              color: _currentIndex != 2 ? _defaultColor : _activeColor),
        )));
    lists.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.account_circle,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          Icons.account_circle,
          color: _activeColor,
        ),
        title: Text(
          "我的",
          style: TextStyle(
              color: _currentIndex != 3 ? _defaultColor : _activeColor),
        )));
    return lists;
  }

//  _bottomNavigationBarItem(BuildContext context, BottomNavItemModel model) {
//    return BottomNavigationBarItem(
//        icon: Icon(
//          Icons.home,
//          color: _defaultColor,
//        ),
//        activeIcon: Icon(
//          Icons.home,
//          color: _activeColor,
//        ),
//        title: Text(
//          model.name,
//          style: TextStyle(
//              color:
//                  _currentIndex != model.index ? _defaultColor : _activeColor),
//        ));
//  }
}
