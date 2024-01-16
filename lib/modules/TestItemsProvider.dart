// test_items_provider.dart
import 'package:alemeno/modules/TaskItemDataModel/TestItemModel.dart';
import 'package:flutter/material.dart';
import '../Widgets/TestWidget.dart';

class TestItemsProvider extends ChangeNotifier {
  List<TestItemModel> _testItems = [];
  List<TestItemModel> _selectedItems = [];
  int paid_amount = 0, savings = 0, mrpTotal = 0, discount = 0;

  List<TestItemModel> get testItems => _testItems;
  List<TestItemModel> get selectedItems => _selectedItems;

  void eraseSelectedItemsList() {
    _selectedItems = [];
  }

  void notifyAll() {
    notifyListeners();
  }

  void setList(List<TestItemModel> list) {
    _testItems = list;
    notifyListeners();
  }

  void toggleSelection(int index) {
    _testItems[index].isSelected = !_testItems[index].isSelected;
    TestItemModel test_item = _testItems[index];
    if (_testItems[index].isSelected) {
      _selectedItems.add(_testItems[index]);
      mrpTotal += test_item.prev_price;
      discount += test_item.prev_price - test_item.price;
      paid_amount += test_item.price;
      savings += test_item.prev_price - test_item.price;
    } else {
      _selectedItems.remove(_testItems[index]);
      mrpTotal -= test_item.prev_price;
      discount -= test_item.prev_price - test_item.price;
      paid_amount -= test_item.price;
      savings -= test_item.prev_price - test_item.price;
    }
    notifyListeners();
  }
}
