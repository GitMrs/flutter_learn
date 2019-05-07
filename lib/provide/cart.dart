import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/model/cartInfo.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  // 声明一个字符串
  String cartString = '[]';
  List<CartInfoMode> cartList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //总数量
  bool isAllCheck = false;
  //保存
  save(goodsId, goodsName, count, price, images) async {
    // 获取一个本地存储的变量
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //本地存储中取得cartInfo的空间
    cartString = prefs.getString('cartInfo');
    //是否为空，空的话赋值为新数组，赋值将取得值decode转成对象
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    // 将其变成数组
    List<Map> tempList = (temp as List).cast();
    //是否存在
    var isHave = false;
    //遍历个数
    int ival = 0;
    //遍历
    tempList.forEach((item) {
      //如果存在
      if (item['goodsId'] == goodsId) {
        // count计数器加1
        tempList[ival]['count'] = item['count'] + 1;

        cartList[ival].count++;
        //将存在的变量改为true
        isHave = true;
      }
      // 存在个数加一
      ival++;
    });
    //如果不存在将其add进数组
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
      // tempList.add({
      //   'goodsId':goodsId,
      //   'goodsName':goodsName,
      //   'count':count,
      //   'price':price,
      //   'images':images
      // });
      
    }
    //将其转义为字符串
    cartString = json.encode(tempList).toString();
    //放到本地存储中
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }
  //移除
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空完成');
    notifyListeners();
  }
  //得到信息
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if(item['isCheck']){
          allPrice+=(item['count']*item['price']);
          allGoodsCount+=item['count'];
        }else{
          isAllCheck = false;
        }
        print(isAllCheck);
        cartList.add(CartInfoMode.fromJson(item));
      });
    }
    notifyListeners();
  }
  //单个删除
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
  //检查是否被选中
  changeCheckState(CartInfoMode cartItem) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
// 点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    // print(isCheck);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = !newItem['isCheck'];
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
  //修改
  addOrReduceAction(var cartItem, String todo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    print(tempList);
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    if(todo=='add'){
      cartItem.count++;
    }else if(cartItem.count>1){
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
