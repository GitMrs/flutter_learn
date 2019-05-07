import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import './router/application.dart';
import './router/router.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/categoryGoods.dart';
import './provide/detail.dart';
import './provide/cart.dart';
import './provide/current_index.dart';
import './animation/animation.dart';
void main(){ 
  var counter = Counter();
  var childCategory =ChildCategory();
  var categoryGoodsListProvide =CategoryGoodsListProvide();
  var detail = DetaillsInfoProvide();
  var providers = Providers();
  var cart = CartProvide();
  var currentIndex = CurrentIndexProvide();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<DetaillsInfoProvide>.value(detail))
    ..provide(Provider<CartProvide>.value(cart))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndex));
  runApp(ProviderNode(child:MyApp(),providers:providers));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    // 声明路由
    final router = Router();
    // 配置路由
    Routes.configureRoutes(router);
    //全局引入
    Application.router = router;
    return Container(
      child:MaterialApp(
        title:'百姓生活',
        debugShowCheckedModeBanner: false,
         //----------------主要代码start
        onGenerateRoute: Application.router.generator,
        //----------------主要代码end
        theme:ThemeData(
          primaryColor:Colors.pink
        ),
        home:OpenAnimation()
      )
    );
  }
}

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       child:MaterialApp(
//         title:'百姓生活',
//         debugShowCheckedModeBanner:false,
//         theme:ThemeData(
//           primaryColor:Colors.pink
//         ),
//         home:IndexPage()
//       ),
//     );
//   }
// }