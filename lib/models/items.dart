import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  late String itemID;
  String? shortInfo;
  String? itemTitle;
  String? description;
  String? itemPrice;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;
  String? menuId;

  Items({
    required this.itemID,
    this.shortInfo,
    this.itemTitle,
    this.description,
    this.itemPrice,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
    this.menuId,

  });

  Items.fromJson(Map<String, dynamic> json) {
    itemID = json["itemID"] ?? ""; // Use empty string as a default value if itemID is missing or null
    shortInfo = json["shortInfo"];
    itemTitle = json["itemTitle"];
    description = json["description"];
    itemPrice = json["itemPrice"];
    publishedDate = json["publishedDate"];
    thumbnailUrl = json["thumbnailUrl"];
    status = json['status'];
    menuId = json['menuId'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["itemId"] = itemID;
    data["shortInfo"] = shortInfo;
    data["itemTitle"] = itemTitle;
    data["description"] = description;
    data["itemPrice"] = itemPrice;
    data["publishedDate"] = publishedDate;
    data["thumbnailUrl"] = thumbnailUrl;
    data["status"]= status;
    data["menuId"]= menuId;

    return data;
  }
}
