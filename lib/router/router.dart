import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handle.dart';
// 全局路由管理
class Routes{
  static String root = '/';
  static String detailsPage = '/detail';
  static String login = '/login';
  // 配置路由
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('error---->not fond');
      }
    );
    router.define(detailsPage,handler:detailsHandler);
    router.define(login,handler:loginHander);
  }
}