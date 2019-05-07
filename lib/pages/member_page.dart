import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../router/application.dart';
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户中心'),

      ),
      body:ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(context),
          _orderType(),
          _actionType()
        ],
      )
    );
  }
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding:EdgeInsets.all(20) ,
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:30),
            child: ClipOval(
              child: Image.network('http://blogimages.jspang.com/blogtouxiang1.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text('技术',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _orderTitle(context){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        onTap: (){Application.router.navigateTo(context,'/login');},
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.white,
      height: ScreenUtil().setHeight(150),
      width: ScreenUtil().setHeight(750),
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode,size: 30,),
                Text('待付款')
              ],
            )
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.build,size: 30,),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car,size: 30,),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste,size: 30,),
                Text('待评论')
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _actionType(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTitle('领取优惠券'),
          _myListTitle('已有优惠券'),
          _myListTitle('地址管理'),
          _myListTitle('客服电话'),
          _myListTitle('关于我们'),
        ],
      ),
    );
  }
  Widget _myListTitle(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          bottom: BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}