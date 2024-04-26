import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String _selectedItem = "Shirt";
  String _selcetedtype = "full sleve";
  String _secteddesign = "Plain";
  String _sectedpant = "Jogger";
  String _Selectedgender = "Men";
  String get selectedtype => _selcetedtype;
  String get Selectedgender => _Selectedgender;
  String get selecteddesign => _secteddesign;
  String get selectedpant => _sectedpant;

  String get selectedItem => _selectedItem;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  void change(String type) {
    _selcetedtype = type;
    notifyListeners();
  }

  void changedesign(String design) {
    _secteddesign = design;
    notifyListeners();
  }

  void setpant(String pant) {
    _sectedpant = pant;
    notifyListeners();
  }

  void setgender(String gender) {
    _Selectedgender = gender;
    notifyListeners();
  }
}
