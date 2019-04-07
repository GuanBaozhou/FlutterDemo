//搜索页的接口实现
//2019-03-29
//管保洲

import 'package:flutter_app/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchDao {
  static Future<SearchModel> fetch(String url,String keyWord) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = new Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
//      只有当前输入内容和数据库返回内容一致时才渲染
      SearchModel model=SearchModel.fromJson(result);
      model.keyword=keyWord;
      return model;
    }else {
      throw Exception("搜索页接口错误");
    }


  }
}
