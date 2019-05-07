import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../router/application.dart';
class HomePage extends StatefulWidget {
  _homePage createState() => _homePage();
}
class _homePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContext = '正在获取数据';
  // String homePageContent = '正在获取数据';
  GlobalKey<RefreshFooterState> _footerkey =GlobalKey<RefreshFooterState>();
  int page= 1;
  List<Map> hotGoodsList = [];
  bool get wantKeepAlive => true;
  void _getHotGoods(){
    var formPage = {'page':page};
      print(formPage);
      request('homePageBelowConten',formPage).then((val){
     
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState((){
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }
  void initState(){
    // print('111111111111111111');
    // _getHotGoods();
    super.initState();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body:FutureBuilder(
        future:request('homePageContext',{'lon': '115.02932', 'lat': '35.76189'}),
        builder: (context,snapshot){
         if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();
            if(navigatorList.length>10){
              navigatorList.removeRange(10, navigatorList.length);
            }
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key:_footerkey,
                bgColor:Colors.white,
                textColor:Colors.pink,
                moreInfoColor:Colors.pink,
                showMore:true,
                noMoreText:'',
                moreInfo:'加载中...',
                loadReadyText:'上拉加载'
              ),
              child:ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                  TopNavigator(navigatorList:navigatorList),   //导航组件
                  AdBanner(advertesPicture:advertesPicture), 
                  LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件  
                  Recommend(recommendList: recommendList),
                  FloorTitle(picture_addess: floor1Title,),
                  FloorContent(floorGoodsList: floor1,),
                  FloorTitle(picture_addess: floor2Title,),
                  FloorContent(floorGoodsList: floor2,),
                  FloorTitle(picture_addess: floor3Title,),
                  FloorContent(floorGoodsList: floor3,),
                  _hotGoods()
                ],
              ),
              loadMore:() async {
                print('加载更多');
                var formData = {'page':page};
                request('homePageBelowConten',formData).then((val){
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              }
            );
         }else{
            return Center(
              child:Text('加载中...'),
            );
          }
        },
      )
    );
  }
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top:10.9),
    padding:EdgeInsets.all(5.0),
    alignment:Alignment.center,
    decoration:BoxDecoration(
      color:Colors.white,
      border:Border(
        bottom:BorderSide(width:0.5,color:Colors.black12)
      )
    ),
    child:Text('火爆专区'),
  );
  Widget _wrapList(){
    if(hotGoodsList.length!=0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap:(){Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");},
          child:Container(
            width:ScreenUtil().setWidth(372),
            color:Colors.white,
            padding:EdgeInsets.all(5.0),
            margin:EdgeInsets.only(bottom:3.0),
            child:Column(
              children:<Widget>[
                Image.network(val['image'],width:ScreenUtil().setWidth(375),),
                Text(
                  val['name'],
                  maxLines:1,
                  overflow:TextOverflow.ellipsis,
                  style:TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(26)),
                ),
                Row(
                  children:<Widget>[
                    Text('￥${val["mallprice"]}'),
                    Text('￥${val["price"]}',style:TextStyle(color:Colors.black12,decoration:TextDecoration.lineThrough)),
                  ],
                )
              ],
            ),
          )
        );
      }).toList();
      return Wrap(
        spacing:2,
        children:listWidget 
      );
    }else{
      return Text('');
    }
  }
  Widget _hotGoods(){
    return Container(
      child:Column(
        children:<Widget>[
          hotTitle,
          _wrapList()
        ]
      )
    );
  }
}
// 轮播图
class SwiperDiy extends StatelessWidget{
  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}):super(key:key);
  @override
  Widget build(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 750,height:1334)..init(context);
    return Container(
      height:ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child:Swiper(
        itemBuilder:(BuildContext context, int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount:swiperDataList.length,
        pagination:new SwiperPagination(),
        autoplay:true
      ),
    );
  }
}
// 顶部导航栏
class TopNavigator extends StatelessWidget{
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}):super(key:key);
  Widget build(BuildContext context){
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        // 解决和ListView滚动冲突问题
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}
// Adbanner
class AdBanner extends StatelessWidget{
  final String advertesPicture;
  AdBanner({Key key,this.advertesPicture}):super(key:key);
  Widget build(BuildContext context){
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}
// 拨打电话
class LeaderPhone extends StatelessWidget{
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({Key key,this.leaderImage,this.leaderPhone}):super(key:key);
  Widget build(BuildContext context){
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }
  void _launchURL() async{
    String url = 'tel:' + leaderPhone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
}
//推荐列表
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key,this.recommendList}):super(key:key);
  //标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        ),
      ),
      child: Text(
        '推荐商品',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }
  //每一项
  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5,color: Colors.black12))
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }
  //横向列表
  Widget _recommendList(){
    return Container(
      height: ScreenUtil().setHeight(350),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(index);
        }
      ),
    );
  }
  
  Widget build(BuildContext context){
    return Container(
      height: ScreenUtil().setHeight(410),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }
}
//楼层标题组件
class FloorTitle extends StatelessWidget{
  String picture_addess;
  FloorTitle({Key key,this.picture_addess}):super(key:key);
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(0.8),
      child: Image.network(picture_addess),
    );
  }
}
//楼层商品组件
class FloorContent extends StatelessWidget{
  final List floorGoodsList;
  FloorContent({Key key,this.floorGoodsList}):super(key:key);
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }
  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2])
          ],
        )
      ],
    );
  }
  Widget _otherGoods(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4])
      ],
    );
  }
  Widget _goodsItem(Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){print('点击了此楼商品');},
        child: Image.network(goods['image']),
      ),
    );
  }
} 
//热门列表
class HotGoods extends StatefulWidget{
  _HotGoodsState createState() => _HotGoodsState();
}
class _HotGoodsState extends State<HotGoods>{
  int page= 1;
  List<Map> hotGoodsList = [];
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top:10.9),
    padding:EdgeInsets.all(5.0),
    alignment:Alignment.center,
    decoration:BoxDecoration(
      color:Colors.white,
      border:Border(
        bottom:BorderSide(width:0.5,color:Colors.black12)
      )
    ),
    child:Text('火爆专区'),
  );
  Widget _wrapList(){
    print(hotGoodsList);
    if(hotGoodsList.length!=0){
      List<Widget> ListWidget = hotGoodsList.map((val){
        return InkWell(
          onTap:(){print('点击了火爆商品');},
          child:Container(
            width:ScreenUtil().setWidth(372),
            color:Colors.white,
            padding:EdgeInsets.all(5.0),
            margin:EdgeInsets.only(bottom:3.0),
            child:Column(
              children:<Widget>[
                Image.network(val['image'],width:ScreenUtil().setWidth(375),),
                Text(
                  val['name'],
                  maxLines:1,
                  overflow:TextOverflow.ellipsis,
                  style:TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(26)),
                ),
                Row(
                  children:<Widget>[
                    Text('￥${val["mallPrice"]}'),
                    Text('￥${val["price"]}',style:TextStyle(color:Colors.black12,decoration:TextDecoration.lineThrough)),
                  ],
                )
              ],
            ),
          )
        );
      }).toList();
      return Wrap(
        spacing:2,
        children:ListWidget
      );
    }else{
      return Text('');
    }
  }
  Widget _hotGoods(){
    return Container(
      child:Column(
        children:<Widget>[
          hotTitle,
          _wrapList()
        ]
      )
    );
  }
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          _hotGoods()
        ],
      ),
    );
  }
}





//swiper
// class  swiperDiy extends StatelessWidget {
//   final List swiperDataList;
//   swiperDiy({Key key, this.swiperDataList}):super(key:key);
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       height: 333.0,
//       child: Swiper(
//         itemBuilder:(BuildContext context, int index){
//           return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
//         },
//         itemCount:swiperDataList.length,
//         pagination:new SwiperPagination(),
//         autoplay: true,
//       ),
//     );
//   }
// }