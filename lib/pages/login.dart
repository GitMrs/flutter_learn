import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Login extends StatefulWidget{
  _login createState() => _login();
}
class _login extends State<Login>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('用户登录',style: TextStyle(color: Colors.white)),
         leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                print('返回上一级');
                Navigator.pop(context);
              },
            ),
      ),
      body:ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:EdgeInsets.all(30),
                child:Image.network(
                  'https://cdn2.jianshu.io/assets/default_avatar/2-9636b13945b9ccf345bc98d0d81074eb.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96',
                  scale: 1.2,
                  width: 200,
                ),
              ),
              Container(
                padding:EdgeInsets.fromLTRB(20.0,0.0,20,15.0),
                child: Stack(
                  alignment:Alignment(1.0, 1.0),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new Padding(
                          padding: EdgeInsets.fromLTRB(0.0,0.0,20.0,0.0),
                          child: Image.network(
                            'https://cdn2.jianshu.io/assets/default_avatar/2-9636b13945b9ccf345bc98d0d81074eb.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96',
                            width: 29,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                        ),
                        new Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '。。。。'
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20,15),
                child: Stack(
                  alignment: Alignment(1.0,1.0),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Image.network(
                            'https://cdn2.jianshu.io/assets/default_avatar/2-9636b13945b9ccf345bc98d0d81074eb.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96',
                            width: 29,
                            height: 29,
                            fit: BoxFit.fill,
                          ),
                        ),
                        new Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'xxxx'
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(320),
                child: Card(
                  color: Colors.blue,
                  elevation: 16,
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    child: Text('登陆',
                      style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(30)),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}