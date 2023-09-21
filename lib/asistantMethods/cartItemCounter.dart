import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';

 class CartItemCounter extends ChangeNotifier{
   int cartListItemCount = sharedPreferences!.getStringList("userCart")!.length - 1;
   int get count => cartListItemCount;

   Future<void> displayCartListItemNumber() async
   {
      cartListItemCount = sharedPreferences!.getStringList("userCart")!.length - 1;// cause we hava one garbage value
      await Future.delayed(const Duration( milliseconds: 100), (){
        notifyListeners();
      });
   }

 }