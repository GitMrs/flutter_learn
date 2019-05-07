import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail.dart';
import 'package:flutter_html/flutter_html.dart';
class DetailWeb extends StatelessWidget{
  Widget build(BuildContext context){
    var goodsDetail = Provide.value<DetaillsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetaillsInfoProvide>(
      builder: (context,child,value){
        var isLeft = Provide.value<DetaillsInfoProvide>(context).isLeft;
        if(isLeft){
          return Container(
            child: Html(
              data:goodsDetail
            ),
          );
        }else{
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂无数据'),
          );
        }
      },
    );
  }
}