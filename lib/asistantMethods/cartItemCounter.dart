import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';

class CartItemCounter extends ChangeNotifier {
  int cartListItemCount = 1; // Initialize to 0 by default

  CartItemCounter() {
    // Constructor: Initialize the count when the provider is created.
    _updateCartItemCount();
  }

  int get count => cartListItemCount;

  Future<void> _updateCartItemCount() async {
    final List<String>? userCart = sharedPreferences!.getStringList("userCart");

    if (userCart != null) {
      // Subtract 1 for the garbage value
      cartListItemCount = userCart.length - 1;
    } else {
      // Handle the case where "userCart" is not found or null
      cartListItemCount = 0;
    }
  }

  Future<void> displayCartListItemNumber() async {
    await _updateCartItemCount();
    notifyListeners();
  }
}
