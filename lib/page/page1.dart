import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:gxxq/page/topics_page.dart';
import '../util/view_util.dart';
import '../model/group.dart';
import '../view/list_item_group.dart';
import '../constant.dart';

class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [
    ];

    GROUPS.forEach((map) {
      Group group = Group.fromJson(map);
      var tgb = group.color.split(',');
      children.add(  _buildGridItem(group, tgb));
    });

    return Scaffold(
        appBar: ViewUtil.getAppBar('共享星球', context,
            leading: false, elevation: 0, color: Colors.transparent),
        body: Column(
          children: <Widget>[
            _renderNotificationText(),
            Expanded(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(27),
                mainAxisSpacing: 27.0,
                crossAxisSpacing: 27.0,
                children: children,
                childAspectRatio: 0.72,
              ),
            )
          ],
        ));
  }

  GestureDetector _buildGridItem(Group group, List<String> tgb) {
    return GestureDetector(
      onTap: (){
        if(group.id != 1){
          Navigator.push(context, CupertinoPageRoute(builder: (context) {
            return TopicsPage(group);
          }));
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                group.image,
                fit: BoxFit.fill,
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Color.fromARGB(255, int.parse(tgb[0]),
                    int.parse(tgb[1]), int.parse(tgb[2])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      group.name,
                      style: TextStyle(
                          fontSize: 15,
                          color: group.color == '255,255,255'
                              ? Colors.black87
                              : Colors.white),
                    ),
                    Container(
                      height: 0.5,
                      width: 18,
                      margin: EdgeInsets.only(top: 4, bottom: 4),
                      color: group.color == '255,255,255'
                          ? Colors.black87
                          : Colors.white,
                    ),
                    Text(
                      group.auth,
                      style: TextStyle(
                          fontSize: 11,
                          color: group.color == '255,255,255'
                              ? Colors.black87
                              : Colors.white),
                    ),
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  //通知
  Container _renderNotificationText() {
    return Container(
      height: 38,
      width: double.infinity,
      color: Color.fromARGB(255, 254, 242, 233),
      child: Center(
        child: Text(
          "禁止商用盗版否则后果自负",
          style:
          TextStyle(color: Color.fromARGB(255, 254, 113, 37), fontSize: 15),
        ),
      ),
    );
  }
}
