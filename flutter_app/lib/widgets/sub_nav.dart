import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/widgets/web_view.dart';
//两排活动入口
class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          children: items.sublist(0, separate),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: items.sublist(separate, subNavList.length),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.url,
                        statusBarColor: model.statusBarColor,
                        title: model.title,
                        hideAppBar: model.hideAppBar,
                        backForbid: false,
                      ),
                ));
          },
          child: Column(
            children: <Widget>[
              Image.network(
                model.icon,
                height: 32,
                width: 32,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }
}
