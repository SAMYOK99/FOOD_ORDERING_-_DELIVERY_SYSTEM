import 'package:flutter/material.dart';

class TotalAmount extends ChangeNotifier{
  double totalamt= 0;
  double get tamount => totalamt;

  displayTotalAmount(double number) async
  {
    totalamt = number;
    await Future.delayed(const Duration(milliseconds: 10),(){
      notifyListeners();

    });
  }

}