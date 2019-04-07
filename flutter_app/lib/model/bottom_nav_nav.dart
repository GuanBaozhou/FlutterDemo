class BottomNavModel {
  final List<BottomNavItemModel> data;

  BottomNavModel({this.data});

  factory BottomNavModel.fromJson(Map<String, dynamic> json) {
    final navJson = json["meun"] as List;
    List<BottomNavItemModel> navList =
        navJson.map((i) => BottomNavItemModel.fromJson(i)).toList();
    return BottomNavModel(
      data: navList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["data"] = this.data;
    return data;
  }
}

class BottomNavItemModel {
  final String name;
  final String icon;
  final int index;


  BottomNavItemModel({this.name, this.icon, this.index});

  factory BottomNavItemModel.fromJson(Map<String, dynamic> json) {
    return BottomNavItemModel(
      name: json["name"],
      icon: json["icon"],
      index: json["index"],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    data["name"] = this.name;
    data["icon"] = this.icon;
    data["index"] = this.index;
    return data;
  }
}
