import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class HomePages extends StatefulWidget {
  _homePageState createState() => _homePageState();
}
class _homePageState extends State<HomePages>{
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎来到美好人间';
  @override 
  Widget build(BuildContext context){
    return Container(
      child:Scaffold(
        appBar:AppBar(title:Text('美好人间')),
        body:SingleChildScrollView(
          child: Container(
          height:1000,
          child:Column(
            children:<Widget>[
              TextField(
                controller:typeController,
                decoration:InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText:'美女类型',
                  helperText:'请输入你喜欢的类型'
                ),
                autofocus:false,
              ),
              RaisedButton(
                onPressed:_choiceAction,
                child:Text('选择完毕')
              ),
              Text(
                showText,
                overflow:TextOverflow.ellipsis,
                maxLines:2,
              ),
            ],
          ),
        ),
        )
      ),
    );
  }
  void _choiceAction(){
    print('开始选择你的类型。。。');
    if(typeController.text.toString() == ''){
      showDialog(
        context:context,
        builder:(context) => AlertDialog(title:Text('美女类型不能为空！'))
      );
    }else{
      print(111);
      getHttp(typeController.text.toString()).then((val){
        
        setState(() {
           showText=val['data']['name'].toString();
         });
      });
    }
  }
  Future getHttp(String TypeText)async{
    try{
      Response response;
      var data = {'name':TypeText};
      response = await Dio().get(
         "https://easy-mock.com/mock/5c734e7333c514218a005155/list",
          queryParameters:data
      );
      print(response.data);
      return response.data;
    }catch(e){
      return print(e);
    }
  }

}