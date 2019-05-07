import 'package:flutter/material.dart';
import '../pages/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //切换小类样式
  String categoryId = '4'; //大类ID
  String subId = '';
  getChildCategory(List<BxMallSubDto> list,String id) {
    categoryId = id;
    childIndex = 0;
    subId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  changeChildeIdex(int index,String id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }
}
