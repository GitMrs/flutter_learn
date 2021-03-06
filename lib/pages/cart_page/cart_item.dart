import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../model/cartInfo.dart';
import './cart_count.dart';
class CartItem extends StatelessWidget{
  final CartInfoMode item;
  CartItem(this.item);
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0,color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context,item),
          _cartImage(item),
          _cartGoodsName(item),
          _cartPrice(context,item)
        ],
      ),
    );
  }
  Widget _cartCheckBt(context,item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val){
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }
  Widget _cartImage(item){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0,color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item)
        ],
      ),
    );
  }
  Widget _cartPrice(context,item){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: (){
                //点击删除
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black12,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}