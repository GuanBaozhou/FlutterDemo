import 'package:flutter/material.dart';
import 'package:flutter_app/dao/Search_dao.dart';
import 'package:flutter_app/model/search_model.dart';
import 'package:flutter_app/pages/speak_page.dart';
import 'package:flutter_app/widgets/search_bar.dart';
import 'package:flutter_app/widgets/web_view.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'signt',
  'ticket',
  'travelgroup',
];

const SEARCH_HOME_URL =
    "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=";

class SearchPage extends StatefulWidget {
  final String hint;
  final String keyword;
  final bool leftHide;
  final String searchUrl;

  const SearchPage(
      {Key key,
      this.hint,
      this.keyword,
      this.leftHide,
      this.searchUrl = SEARCH_HOME_URL})
      : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  SearchModel searchModel;
  String keyWord;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          Expanded(
            flex: 1,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: searchModel?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return _item(index);
                    })),
          ),
        ],
      ),
    );
  }

  _item(int index) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[index];
    print(item.word);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.url,
                      title: '详情',
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 5),
                child: Image(
                    height: 26,
                    width: 26,
                    image: AssetImage(_typeImage(item.type)))),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  child: _subTitle(item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _title(SearchItem item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordText(item.word, searchModel.keyword));
//    print("item.districtName====> ${item.districtName} ${item.zoneName} ${item.price} ");
    spans.add(
      TextSpan(
          text: ' ' + (item.districtName ?? '') + ' ' + (item.zoneName ?? ''),
          style: TextStyle(color: Colors.grey, fontSize: 16)),
    );

    return RichText(text: TextSpan(children: spans));
  }

  _keywordText(String word, String keyWord) {

    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyWord);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
//        print('i的值是：$i');
//        print('arr[i]的值是：${arr[i]}');
        spans.add(TextSpan(text: keyWord, style: keywordStyle));
      }
      String val = arr[i];
//      print('val：$val');
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: item.price??'',style:TextStyle(fontSize: 16,color: Colors.orange)),
          TextSpan(text:  ' ' +(item.start??''),style:TextStyle(fontSize: 12,color: Colors.grey)),
        ]
      ),
    );
  }

  //根据item的类型返回图片
  _typeImage(String type) {
    if (type == null) return 'images/type_travelgroup.png';
    var path = "travelgroup";
    for (var val in TYPES) {
      if (TYPES.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  //文本变化
  _onTextChange(String text) {
//    print(text);
    keyWord = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + keyWord;
    SearchDao.fetch(url, text).then((SearchModel model) {
      if (model.keyword == keyWord) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }
  _jumpToSpeak() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SpeakPage()));
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 30),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SearchBar(
              enabled: true,
              hideLeft: widget.leftHide,
              searchBarType: SearchBarType.normal,
              defaultText: widget.keyword,
              hint: widget.hint,
              speakClick: _jumpToSpeak,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }
}
