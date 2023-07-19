class Menus {
  String? menuTitle;

  Menus({
    this.menuTitle,
  });

  Menus.fromJson(Map<String, dynamic> json){
    menuTitle = json['menuTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["menuTitle"] = menuTitle;
    return data;
  }
}