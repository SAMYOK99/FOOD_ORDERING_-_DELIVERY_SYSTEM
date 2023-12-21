import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

import '../globalVariables/globleVariable.dart';
import 'cartItemCounter.dart';

separateItemIds(){
  List<String> defaultItemList= [], separateItemIdList=[];

  defaultItemList = sharedPreferences!.getStringList("userCart")!;
  for(int i = 1; i<defaultItemList.length; i ++) {
    String item = defaultItemList[i]
        .toString(); // it is in the form of 12341 : 1
    // now only 1 which is the number of quantity of items
    var pos = item.lastIndexOf(":"); // now only 1234
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;// get data from 0 till pos
    separateItemIdList.add(getItemId);
  }
  return separateItemIdList;

}
separateOrderItemIds(orderIDs){
  List<String> defaultItemList= [], separateItemIdList=[];

  defaultItemList = List<String>.from(orderIDs);
  for(int i = 1; i<defaultItemList.length; i ++) {
    String item = defaultItemList[i]
        .toString(); // it is in the form of 12341 : 1
    // now only 1 which is the number of quantity of items
    var pos = item.lastIndexOf(":"); // now only 1234
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;// get data from 0 till pos
    separateItemIdList.add(getItemId);
  }
  return separateItemIdList;

}
addItemToCart(String? foodId, BuildContext context, int intCounter){

  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add("${foodId!}: $intCounter");

  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser?.uid)
      .update({
    "userCart": tempList,

  }).then((value){
    sharedPreferences!.setStringList("userCart", tempList);
    Fluttertoast.showToast(msg: "Item Added to Cart");
    Provider.of<CartItemCounter>(context,listen:false ).displayCartListItemNumber();

  });
  //update the badge


}
separateItemQuantiteis(){
  List<int> separateItemQuantityList=[];
  List<String> defaultItemList= [];
  defaultItemList = sharedPreferences!.getStringList("userCart")!;
  for(int i = 1; i<defaultItemList.length; i ++)
  {
    String item = defaultItemList[i].toString(); // it is in the form of 12341 : 1
    // now only 1 which is the number of quantity of items
    List<String> listItemChar = item.split(":").toList();
    // index 0 = left of :
    //index 1 = right of :
    var ItemQuantity = int.parse(listItemChar[1].toString());

    separateItemQuantityList.add(ItemQuantity);// actual ids of item
    print("\nThis is Quantity Number = " + ItemQuantity.toString());


  }
  return separateItemQuantityList;

}
separateOrderItemQuantiteis(orderIDs){
  List<String> separateItemQuantityList=[];
  List<String> defaultItemList= [];
  defaultItemList = List<String>.from(orderIDs);
  for(int i = 1; i<defaultItemList.length; i ++)
  {
    String item = defaultItemList[i].toString(); // it is in the form of 12341 : 1
    // now only 1 which is the number of quantity of items
    List<String> listItemChar = item.split(":").toList();
    // index 0 = left of :
    //index 1 = right of :
    var ItemQuantity = int.parse(listItemChar[1].toString());

    separateItemQuantityList.add(ItemQuantity.toString());// actual ids of item
    print("\nThis is Quantity Number = " + ItemQuantity.toString());


  }
  return separateItemQuantityList;

}

void clearCart(BuildContext context) {
  sharedPreferences!.setStringList("userCart", ['garbage']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) {
    sharedPreferences!.setStringList("userCart", emptyList!);

    // Update the cart item count in real-time
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemNumber();

    Fluttertoast.showToast(msg: "Cart has been cleared");
  });
}



