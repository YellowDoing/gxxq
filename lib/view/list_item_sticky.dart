import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gxxq/util/element_parser.dart';
import '../model/topic.dart';
import '../page/topic_detail.dart';
import '../view/list_item_topic.dart';

//置顶
class StickyListItem extends StatelessWidget {

  final Topic _topic;

  StickyListItem(this._topic);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) {
          return TopicDetailPage(_topic);
        }));
      },
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  '置顶', style: TextStyle(fontSize: 10, color: Colors.grey),),
              ),
              Expanded(
                flex: 1,
                child: Text(ElementParser.hasE(_topic.talk.text) ? ElementParser.genEText(_topic.talk.text,context).textSpans[0].text
                    :_topic.talk.text, maxLines: 1,
                  overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          _line()
        ],
      ),
    );
  }

  _line() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: Colors.black12,
    );
  }
}
