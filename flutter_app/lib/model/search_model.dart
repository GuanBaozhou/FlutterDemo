//searchModel设计
//2019-3-29
//管保洲

class SearchModel {
   String keyword;
  final List<SearchItem> data;

  SearchModel({this.data,this.keyword});
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final searchList = json["data"] as List;
    List<SearchItem> searchItem =
        searchList.map((i) => SearchItem.fromJson(i)).toList();
    return SearchModel(
      data: searchItem,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["data"] = this.data;

    return data;
  }
}

class SearchItem {
  final String word;
  final String type;
  final String price;
  final String start;
  final String zoneName;
  final String districtName;
  final String url;

  SearchItem(
      {this.word,
      this.type,
      this.price,
      this.start,
      this.zoneName,
      this.districtName,
      this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json["word"],
      type: json["type"],
      price: json["price"],
      start: json["star"],
      zoneName: json["zonename"],
      districtName: json["districtname"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["word"] = this.word;
    data["type"] = this.type;
    data["price"] = this.price;
    data["start"] = this.start;
    data["zoneName"] = this.zoneName;
    data["districtName"] = this.districtName;
    data["url"] = this.url;

    return data;
  }
}
