import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? itemUID;
  String? shortInfo;
  String? itemTitle;
  String? itemDescription;
  String? itemPrice;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;

  Items({
    this.itemUID,
    this.shortInfo,
    this.itemTitle,
    this.itemDescription,
    this.itemPrice,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,

  });

  Items.fromJson(Map<String, dynamic> json){

    itemUID=json["itemUID"];
    shortInfo=json["shortInfo"];
    itemTitle=json["itemTitle"];
    itemDescription =json["itemDescription"];
    itemPrice=json["itemPrice"];
    publishedDate=json["publishedDate"];
    thumbnailUrl=json["thumbnailUrl"];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["itemUID"] = itemUID;
    data["shortInfo"] = shortInfo;
    data["itemTitle"] = itemTitle;
    data["itemDescription"] = itemDescription;
    data["itemPrice"] = itemPrice;
    data["publishedDate"] = publishedDate;
    data["thumbnailUrl"] = thumbnailUrl;
    data["status"]= status;

    return data;
  }
}
