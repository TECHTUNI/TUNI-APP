import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;

  void onTabChange (int index) {
    currentIndex = index;
    notifyListeners();
  }

}