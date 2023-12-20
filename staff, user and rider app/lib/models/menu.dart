import 'package:flutter/material.dart';

class Menu extends ChangeNotifier {
  String? menuId;
  String? menuTitle;
  String? selectedTab;

  Menu({
    this.menuId,
    this.menuTitle,
    this.selectedTab,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuId: json['menuId'],
      menuTitle: json['menuTitle'],
    );
  }

  void updateSelectedTab(String menuId) {
    selectedTab = menuId;
    notifyListeners(); // Notify listeners when the selectedTab changes
  }
}
