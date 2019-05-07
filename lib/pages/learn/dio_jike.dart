import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../config/httpHeaders.dart';

class DioJike extends StatefulWidget {
  Home_jike createState() => Home_jike();
}

class Home_jike extends State<DioJike> {
  String showText = '还没有请求数据';
  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('请求远程数'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _jike,
              child: Text('请求数据'),
            ),
            Text(showText)
          ],
        ),
      ),
    );
  }

  void _jike() {
    print('开始向极客时间请求数据..................');
    getHttp().then((val) {
      setState(() {
        showText = val.toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response =
          await dio.get("http://c1614.f28014.cn/public/function.html?act=new_chapter&page=1");
      print(response);
      return response.data;
      // Response response;
      // Dio dio = new Dio();
      //   response =await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
      //   print(response);
      //   return response.data;
    } catch (e) {
      print(e);
    }
  }
}
