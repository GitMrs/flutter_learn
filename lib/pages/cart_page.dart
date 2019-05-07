/** 页面 */
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // List cartList = Provide.value<CartProvide>(context).cartList;
            return Stack(
              children: <Widget>[
                // ListView.builder(
                //   itemCount: cartList.length,
                //   itemBuilder: (context,index){
                //     return CartItem(cartList[index]);
                //   },
                // ),
                Provide<CartProvide>(
                  builder: (context,child,childCategory){
                    List cartList = Provide.value<CartProvide>(context).cartList;
                    print(cartList);
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context,index){
                        return CartItem(cartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}

/** shared_preferences 例子 */
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartPage extends StatefulWidget {
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   List<String> testList = [];
//   void _add() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String temp = '技术胖';
//     testList.add(temp);
//     prefs.setStringList('testInfo', testList);
//     _show();
//   }

//   void _show() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       if (prefs.getStringList('testInfo') != null) {
//         testList = prefs.getStringList('testInfo');
//       }
//     });
//   }

//   void _clear() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('testInfo');
//     setState(() {
//       testList = [];
//     });
//   }

//   Widget build(BuildContext context) {
//     _show();
//     return Container(
//       child:Column(
//         children: <Widget>[
//           Container(
//             height: 500.0,
//             child: ListView.builder(
//               itemCount: testList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(testList[index]),
//                 );
//               },
//             ),
//           ),
//           RaisedButton(
//             onPressed: () {
//               _add();
//             },
//             child: Text('增加'),
//           ),
//           RaisedButton(
//             onPressed: () {
//               _clear();
//             },
//             child: Text('清空'),
//           )
//         ],
//       ),
//     );
//   }
// }
/** 最开始例子 */
// import '../provide/counter.dart';
// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Scaffold(
//       appBar: AppBar(
//         title: Text('购物车'),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[Number(), Mybutton()],
//         ),
//       ),
//     ));
//   }
// }

// class Number extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 30),
//       child: Provide<Counter>(builder: (context, child, counter) {
//         return Text(
//           '${counter.value}',
//           style: Theme.of(context).textTheme.display1,
//         );
//       }),
//     );
//   }
// }

// class Mybutton extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Container(
//         child: RaisedButton(
//       onPressed: () {
//         Provide.value<Counter>(context).increment();
//       },
//       child: Text('递增'),
//     ));
//   }
// }
