import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/widgets/web_view.dart';

//四个导航景点游玩，一日游吃喝
class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key,@required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 64,
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
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model){
      items.add(_item(context,model));
    });
    return Row(
      children: items,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    //可点击组件
    return GestureDetector(
      onTap: () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>
         WebView(url: model.url,statusBarColor: model.statusBarColor,title: model.title,
             hideAppBar: model.hideAppBar,backForbid: false,),

     ));


      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 32,
            width: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
