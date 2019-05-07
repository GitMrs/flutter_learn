import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail.dart';
import './detail_info/details_top_area.dart';
import './detail_info/details_explain.dart';
import './detail_info/details_bar.dart';
import './detail_info/details_web.dart';
import './detail_info/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                print('返回上一级');
                Navigator.pop(context);
              },
            ),
            title: Text('商品详情')),
        body: FutureBuilder(
            future: _getGoodInfo(context),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    Container(
                      child: ListView(
                        children: <Widget>[
                          DetailTopArea(),
                          DetailExplain(),
                          DetailTabar(),
                          DetailWeb(),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child:  DetailBottom(),
                    )
                  ],
                );
              } else {
                return Text('加载中....');
              }
            }));
  }

  Future _getGoodInfo(BuildContext context) async {
    await Provide.value<DetaillsInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完成';
  }
}
