import 'package:flutter/material.dart';
import 'package:gxxq/model/comment.dart';
import 'package:gxxq/util/date_util.dart';
import 'package:gxxq/util/element_parser.dart';
import '../constant.dart';
import '../model/topic.dart';

class CommentListItem extends StatelessWidget {
  final Comment _comment;

  CommentListItem(this._comment);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _avatarNameTime(),
        _renderContentText(context),
        _renderChildComments(context),
        _line(),
      ],
    );
  }

  /* 渲染文本 */
  Widget _renderContentText(BuildContext context) {
    if (_comment.text != null) {
      Widget child;
      if (ElementParser.hasE(_comment.text)) {
        final styleBlack = TextStyle(color: Colors.black);
        final textSpans = <TextSpan>[];

        ParseResult parseResult =
        ElementParser.genEText(_comment.text, context);

        textSpans.addAll(parseResult.textSpans);
        textSpans
            .add(TextSpan(text: parseResult.textResult, style: styleBlack));

        child = RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 15),
            children: textSpans,
          ),
        );
      } else {
        child = Text(
          _comment.text,
          style: TextStyle(fontSize: 15),
        );
      }

      return Padding(
        padding: EdgeInsets.only(left: 54, top: 6, right: 16),
        child: child,
      );
    } else
      return Container();
  }

  //头像
  Widget _avatarNameTime() {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 14),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              _comment.owner.avatarUrl,
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
                  _comment.owner.name,
                  style: TextStyle(color: BLUE_DARK),
                ), //名字

                Padding(
                  padding: EdgeInsets.only(top: 1.5),
                  child: Text(
                    DateUtil.timeStr(_comment.createTime),
                    style: TextStyle(color: Colors.black38, fontSize: 10),
                  ),
                ), //时间
              ],
            ),
          ),
        ],
      ),
    );
  }

  _line() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      width: double.infinity,
      height: 0.5,
      color: Colors.black12,
    );
  }

  /* 子评论 */
  _renderChildComments(BuildContext context) {
    if (_comment.repliesCount != null) {
      const style = TextStyle(color: BLUE_DARK, fontSize: 15);
      const styleBlack = TextStyle(color: Colors.black87);

      final comments = <Widget>[];
      _comment.repliedComments.forEach((showComments) {
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

      return Padding(
        padding: EdgeInsets.only(left: 54, top: 6, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments,
        ),
      );
    } else
      return Container();
  }
}
