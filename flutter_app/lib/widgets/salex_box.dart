import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/sales_box_model.dart';
import 'package:flutter_app/widgets/web_view.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBox({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;
    List<Widget> lists = [];
    lists.add(_doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    lists.add(_doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    lists.add(_doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2d2f2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                salesBox.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Color(0xffff4E63), Color(0xffff6cc9)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WebView(url: salesBox.moreUrl, title: "更多活动")));
                  },
                  child: Text(
                    '获取更多福利 >>',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lists.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lists.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lists.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool isBig, bool isLast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftCard, isBig, true, isLast),
        _item(context, rightCard, isBig, false, isLast)
      ],
    );
  }

  _item(BuildContext context, CommonModel card, bool isBig, bool isLeft,
      bool isLast) {
    BorderSide borderSide = BorderSide(color: Color(0xfff2f2f2), width: 1);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView(
                    url: card.url,
                    statusBarColor: card.statusBarColor,
                    title: card.title,
                    hideAppBar: card.hideAppBar,
                    backForbid: false,
                  ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              right: isLeft ? borderSide : BorderSide.none,
              bottom: isLast ? BorderSide.none : borderSide),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              card.icon,
              fit: BoxFit.fill,
              height: isBig ? 129 : 80,
              width: MediaQuery.of(context).size.width / 2 - 15,
            ),
          ],
        ),
      ),
    );
  }
}
