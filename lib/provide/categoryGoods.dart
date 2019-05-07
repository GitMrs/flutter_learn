import 'package:flutter/material.dart';
import '../pages/model/categoryGoodsList.dart';
class CategoryGoodsListProvide with ChangeNotifier  {
  List<CategoryListData> goodList = [];
  getGoodsList(List<CategoryListData> list){
    goodList = list;
    notifyListeners();
  }
}