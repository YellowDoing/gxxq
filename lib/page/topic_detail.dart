import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gxxq/model/comment.dart';
import 'package:gxxq/util/date_util.dart';
import 'package:gxxq/util/element_parser.dart';
import 'package:gxxq/view/list_item_comment.dart';
import 'package:gxxq/view/topic_images.dart';


import '../constant.dart';
import '../model/topic.dart';

import '../util/view_util.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic _topic;

  TopicDetailPage(this._topic);

  @override
  State<StatefulWidget> createState() => _TopicDetailState(_topic);
}

class _TopicDetailState extends State<TopicDetailPage> {
  final Topic _topic;
  List<ShowComments> _comments = List<ShowComments>();
  ScrollController _controller;

  _TopicDetailState(this._topic) {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          _comments.length % 30 == 0) {
        _getComments(isLoadMore: _comments.length > 0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtil.getAppBar('详情', context),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: _avatarNameTime(),
              padding: EdgeInsets.all(16),
            ),
            _renderQuestion(),
            _renderContentText(context),
            _renderFiles(),
            _renderImages(context),
            _renderLikePeople(),
            _line(),
//            Column(
//              children: _comments.map((c) => CommentListItem(c)).toList(),
//            ),
            Container(
              width: double.infinity,
              child: Offstage(
                offstage: _comments.length == 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: Text(
                    _comments.length % 30 == 0 ? '加载中...' : '没有更多了',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _line() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: double.infinity,
      height: 0.5,
      color: Colors.black12,
    );
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
              width: 33,
              height: 33,
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
          text: TextSpan(
            style: TextStyle(fontSize: 15),
            children: textSpans,
          ),
        );
      } else {
        child = Text(
          type == 'talk' ? _topic.talk.text : _topic.answer.text,
          style: TextStyle(fontSize: 15),
        );
      }

      return Padding(
        padding: EdgeInsets.only(left: 20, right: 16),
        child: child,
      );
    } else
      return Container();
  }

  //渲染问题
  Widget _renderQuestion() {
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
        margin: EdgeInsets.only(left: 20, right: 16, bottom: 5),
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
        padding: EdgeInsets.only(left: 18, top: 12),
        child: renderWidget,
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
        padding: EdgeInsets.only(left: 20, right: 16, top: 16),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          children: likeTexts,
        ),
      );
    } else
      return Container();
  }

  //获取评论
  _getComments({isLoadMore = false}) {

    setState(() {_comments = _topic.showComments;

        });
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
//    var sp = await SharedPreferences.getInstance();
//    var headers = Map<String, String>();
//    headers[User_Agent] = sp.getString(User_Agent);
//    var data = await NetUtils.get('$ZSXQ_FILES/${file.fileId}/download_url',
//        headers: headers);
//    DownloadUrl downloadUrl = DownloadUrl.fromJson(data);
//    if (Platform.isIOS)
//      _launchURL(downloadUrl.downloadUrl);
//    else
//      MyPlugin.open(downloadUrl.downloadUrl, file.name);
  }

}
