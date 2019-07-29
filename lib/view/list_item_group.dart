import 'package:flutter/material.dart';
import '../model/group.dart';

class GroupListItem extends StatelessWidget {

  final Group _group;
  final GestureTapCallback _onTap;

  GroupListItem(this._group, this._onTap,{Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    var tgb = _group.color.split(',');
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
//            Expanded(
//              child: Image.network(
//                _group.image,
//                fit: BoxFit.fill,
//              ),
//              flex: 5,
//            ),
//            Expanded(
//              child: Container(
//                width: double.infinity,
//                color: Color.fromARGB(255, int.parse(tgb[0]),
//                    int.parse(tgb[1]), int.parse(tgb[2])),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      _group.name,
//                      style: TextStyle(
//                          fontSize: 15,
//                          color: _group.color == '255,255,255'
//                              ? Colors.black87
//                              : Colors.white),
//                    ),
//                    Container(
//                      height: 0.5,
//                      width: 18,
//                      margin: EdgeInsets.only(top: 4, bottom: 4),
//                      color: _group.color == '255,255,255'
//                          ? Colors.black87
//                          : Colors.white,
//                    ),
//                    Text(
//                      _group.auth,
//                      style: TextStyle(
//                          fontSize: 11,
//                          color: _group.color == '255,255,255'
//                              ? Colors.black87
//                              : Colors.white),
//                    ),
//                  ],
//                ),
//              ),
//              flex: 2,
//            ),
          ],
        ),
      ),
    );
  }
}
