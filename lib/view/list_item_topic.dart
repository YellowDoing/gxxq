import 'dart:io';
import 'dart:io' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gxxq/util/element_parser.dart';

import '../constant.dart';
import '../model/topic.dart';
import '../page/topic_detail.dart';
import '../view/topic_images.dart';
import '../util/date_util.dart';

class TopicListItem extends StatelessWidget {
  final Topic _topic;

  TopicListItem(this._topic);

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
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _avatarNameTime(),
                  _renderQuestion(context),
                  _renderContentText(context), //内容文本
                  _renderFiles(),
                  _renderImages(context),
                  _renderLikePeople(),
                  _renderComments(context),
                ],
              ),
            ),
            _line(), //分割线
          ],
        ));
  }

  _renderFiles() {
    if (_topic.type == 'talk' &&
        _topic.talk.files != null &&
        _topic.talk.files.length > 0) {
      var widgets = <Widget>[];
      _topic.talk.files.forEach((file) {
        widgets.add(GestureDetector(
          onTap: () {
            openfile(file);
          },
          child: Container(
            margin: EdgeInsets.only(top: 2),
            color: Colors.grey[200],
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: <Widget>[
                Icon(Icons.attach_file, color: GREEN),
                Expanded(
                    flex: 1,
                    child: Text(
                      '附件: ' + file.name,
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                    ))
              ],
            ),
          ),
        ));
      });

      return Padding(
        padding: EdgeInsets.only(left: 38, top: 9),
        child: Column(
          children: widgets,
        ),
      );
    } else
      return Container();
  }

  Future openfile(File file) async {

  }

  //图片
  _renderImages(BuildContext context) {
    if (_topic.type == 'talk' && _topic.talk.images != null) {
      var renderWidget;
      var images = _topic.talk.images;

      if (images.length == 1) {
        //单图
        renderWidget = TopicImages.singleImage(images, context);
      } else if (images.length == 2) {
        //双图
        renderWidget = TopicImages.doubleImage(images, context);
      } else if (images.length == 4) {
        //四图
        renderWidget = TopicImages.fourImages(images, context);
      } else {
        //多图
        renderWidget = TopicImages.multiImages(images, context);
      }

      return Padding(
        padding: EdgeInsets.only(left: 38, top: 9),
        child: renderWidget,
      );
    } else
      return Container();
  }

  /* 评论 */
  _renderComments(BuildContext context) {
    if (_topic.commentsCount > 0) {
      const style = TextStyle(color: BLUE_DARK, fontSize: 15);
      const styleBlack = TextStyle(color: Colors.black87);

      final comments = <Widget>[];
      _topic.showComments.forEach((showComments) {
        final textSpans = <TextSpan>[];

        bool hasRepliee = showComments.repliee != null;
        //如果回复的是评论
        if (hasRepliee) {
          textSpans.add(TextSpan(text: '回复', style: styleBlack));
          textSpans.add(TextSpan(text: '${showComments.repliee.name}: '));
        }

        String comment;

        if (ElementParser.hasE(showComments.text)) {
          ParseResult parseResult =
          ElementParser.genEText(showComments.text, context);
          textSpans.addAll(parseResult.textSpans);
          comment = parseResult.textResult;
        } else
          comment = showComments.text;

        textSpans.add(TextSpan(text: comment, style: styleBlack));

        comments.add(Padding(
          padding: EdgeInsets.only(top: 3),
          child: RichText(
            text: TextSpan(
                text: '${showComments.owner.name}' + (hasRepliee ? '' : ': '),
                children: textSpans,
                style: style),
          ),
        ));
      });

      if (_topic.commentsCount > 8) {
        //查看更多
        comments.add(
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: InkWell(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return TopicDetailPage(_topic);
                }));
              },
              child: Text(
                '查看更多>',
                style: style,
              ),
            ),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.only(left: 38, top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments,
        ),
      );
    } else
      return Container();
  }

  //点赞
  Widget _renderLikePeople() {
    if (_topic.likesCount > 0) {
      var likeTexts = <Widget>[];
      likeTexts.add(
        Image.asset(
          'assets/images/ic_topic_like_members.png',
          width: 15,
          height: 15,
        ),
      );
      _topic.latestLikes.forEach((latestLike) {
        likeTexts.add(Text(
          '${latestLike.owner.name},',
          style: TextStyle(color: BLUE_DARK),
        ));
      });
      return Padding(
        padding: EdgeInsets.only(left: 38, top: 9),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          children: likeTexts,
        ),
      );
    } else
      return Container();
  }

  _line() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: Colors.black12,
    );
  }

  //渲染问题
  Widget _renderQuestion(BuildContext context) {
    if (_topic.type == 'q&a') {
      String name =
      _topic.question.anonymous ? '匿名用户' : _topic.question.owner.name;

      var textSpans = List<TextSpan>();
      textSpans.add(
          TextSpan(text: ' 回复: ', style: TextStyle(color: Colors.black87)));

      if (ElementParser.hasE(_topic.question.text)) {
        final styleBlack = TextStyle(color: Colors.black);

        ParseResult parseResult =
        ElementParser.genEText(_topic.question.text, context);

        textSpans.addAll(parseResult.textSpans);
        textSpans
            .add(TextSpan(text: parseResult.textResult, style: styleBlack));
      } else {
        textSpans.add(TextSpan(
            text: _topic.question.text,
            style: TextStyle(color: Colors.black87)));
      }

      return Container(
        padding: EdgeInsets.only(left: 7),
        margin: EdgeInsets.only(left: 38, top: 8),
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Color.fromARGB(255, 208, 208, 208), width: 3)),
        ),
        child: RichText(
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: name,
            style: TextStyle(
              color: name == '匿名用户' ? Colors.grey : BLUE_DARK,
              fontSize: 15,
            ),
            children: textSpans,
          ),
        ),
      );
    } else
      return Container();
  }

  /* 渲染文本 */
  Widget _renderContentText(BuildContext context) {
    var type = _topic.type;
    if ((type == 'talk' && _topic.talk.text != null) ||
        (type == 'q&a' && _topic.answer.text != null)) {
      Widget child;
      if (ElementParser.hasE(
          type == 'talk' ? _topic.talk.text : _topic.answer.text)) {
        final styleBlack = TextStyle(color: Colors.black);
        final textSpans = <TextSpan>[];

        ParseResult parseResult = ElementParser.genEText(
            type == 'talk' ? _topic.talk.text : _topic.answer.text, context);

        textSpans.addAll(parseResult.textSpans);
        textSpans
            .add(TextSpan(text: parseResult.textResult, style: styleBlack));

        child = RichText(
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(fontSize: 15),
            children: textSpans,
          ),
        );
      } else {
        child = Text(
          type == 'talk' ? _topic.talk.text : _topic.answer.text,
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15),
        );
      }

      return Padding(
        padding: EdgeInsets.only(left: 38, top: 8),
        child: child,
      );
    } else
      return Container();
  }

  //头像
  Widget _avatarNameTime() {
    var type = _topic.type;
    if (type == 'talk' || type == 'q&a') {
      return Row(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              type == 'talk'
                  ? _topic.talk.owner.avatarUrl
                  : _topic.answer.owner.avatarUrl,
              width: 30,
              height: 30,
            ),
          ), //头像

          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  type == 'talk'
                      ? _topic.talk.owner.name
                      : _topic.answer.owner.name,
                  style: TextStyle(color: BLUE_DARK, fontSize: 12),
                ), //名字

                Padding(
                  padding: EdgeInsets.only(top: 1.5),
                  child: Text(
                    DateUtil.timeStr(_topic.createTime),
                    style: TextStyle(color: Colors.black38, fontSize: 9),
                  ),
                ),
                //时间
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }


}
