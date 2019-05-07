import 'package:flutter/material.dart';
import '../pages/model/detail.dart';
import '../service/service_method.dart';
import 'dart:convert';
class DetaillsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo;
  bool isLeft = true;
  bool isRight = false;
  getGoodsInfo(String id) async{
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData).then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
  //改变tabbar
  changeLeftAndRight(String changeState){
    if(changeState == 'left'){
      isLeft=true;
      isRight=false;
    }else{
      isLeft=false;
      isRight=true;
    }
    notifyListeners();
  }
}
