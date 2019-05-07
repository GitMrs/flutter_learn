import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/httpHeaders.dart';
import '../config/service_url.dart';
// 整合写法
Future request(url,formData) async{
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =ContentType.parse('application/x-www-form-urlencoded');
    if(formData == null){
      response =await dio.post(servicePath[url]);
    }else{
      response =await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode == 200){
      return response.data;
    }else{
      return Exception('服务器异常。。。。。');
    }
  } catch (e) {
    return print('ERROR======>${e}');
  }
}
//分开写法
Future getHomePageContent() async{
  try{
    print('start get data');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse('application/x-www-form-urlencoded');
     var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response =await dio.post(servicePath['homePageContext'],data:formData);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('服务器异常');
    }
  }catch(e){
    print(e);
  }
}
Future getHomePageBeloConten() async{
  try{
    print('开始获取下拉列表数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =ContentType.parse('application/x-www-form-urlencoded');
    int page = 1;
    response =await dio.post(servicePath['homePageBelowConten'],data:page);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('服务器异常');
    }
  }catch(e){
   return print('ERROR:======>${e}');
  }
} 
//模拟请求头
Future getHeader() async{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.headers = httpHeaders;
    response = await dio.get('xxxxx');
    print(response);
    return response;

  }catch(e){
    return print(e);
  }
}