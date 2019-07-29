import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gxxq/constant.dart';
import 'package:gxxq/model/topic.dart';
import 'package:gxxq/model/topic_type.dart';
import 'package:gxxq/view/list_item_sticky.dart';
import 'package:gxxq/view/list_item_topic.dart';
import '../model/group.dart';
import '../util/view_util.dart';

class TopicsPage extends StatefulWidget {
  final Group _group;
  int data;

  TopicsPage(this._group);

  @override
  State createState() => _TopicsPageState(_group, data);
}

class _TopicsPageState extends State<TopicsPage> {
  final Group _group;
  var _topics = new List<Topic>();
  final int data;

  _TopicsPageState(this._group, this.data);

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _getData();
    _getSticky();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        //上拉加载更多
      }
    });
  }

  //获取置顶
  void _getSticky() {
    var topics = STICKY[_group.id]["resp_data"]['topics'];
    setState(() {
      for (int i = topics.length - 1; i > -1; i--) {
        var topic = Topic.fromJson(topics[i]);
        _topics.insert(0, topic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          _renderSliverBar(),
          SliverList(
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              if (index < _topics.length) {
                var topic = _topics[index];
                if (topic.sticky == true)
                  return StickyListItem(topic);
                else
                  return TopicListItem(topic);
              } else {
                return Offstage(
                  offstage: _topics.length == 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      '没有更多了',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                );
              }
            }, childCount: _topics.length + 1),
          ),
        ],
      ),
    );
  }

  _getData() {
    setState(() {
      TOPICS[_group.id]["resp_data"]['topics'].forEach((v) {
        var topic = Topic.fromJson(v);
        _topics.add(topic);
      });
    });
  }

  SliverAppBar _renderSliverBar() {
    final menus = [
      TopicType('digests', 'assets/images/ic_jinghua.png', '精华主题'),
      TopicType('by_owner',
          'assets/images/ic_filter_groupowner_topic_normal.png', '只看题主'),
      TopicType('with_images', 'assets/images/ic_filter_image_topic_normal.png',
          '图片主题'),
      TopicType('with_files', 'assets/images/ic_filter_file_topic_normal.png',
          '文件主题'),
      TopicType('questions',
          'assets/images/ic_filter_question_topic_normal.png', '问答主题'),
      TopicType('all', 'assets/images/ic_filter_all_topic_normal.png', '所有主题')
    ];

    var items = List<PopupMenuItem<TopicType>>();
    menus.forEach((topicType) => items.add(PopupMenuItem<TopicType>(
        value: topicType,
        child: Wrap(
            spacing: topicType.scope == 'digests' ? 8 : 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              topicType.scope == 'digests'
                  ? Image.asset(topicType.image, width: 31, height: 28)
                  : Padding(
                      padding: EdgeInsets.only(left: 4),
                      child:
                          Image.asset(topicType.image, width: 23, height: 23),
                    ),
              Text(topicType.text),
              PopupMenuDivider(),
            ]))));

    return SliverAppBar(
      leading: IconButton(
        icon: Image.asset(
          'assets/images/back.png',
          width: 21,
          height: 21,
        ),
        onPressed: () => Navigator.pop(context),
      ),

      actions: <Widget>[
        InkWell(
          highlightColor: Colors.black12,
          splashColor: Colors.black12,
          onTap: () {
            showMenu<TopicType>(
                    context: context,
                    items: items,
                    position: RelativeRect.fromLTRB(1, 30, 0, 0))
                .then((topicType) {
              Fluttertoast.showToast(msg: '暂不支持');
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Icon(Icons.format_line_spacing),
          ),
        ),
      ],

      //标题是否居中
      elevation: 1,
      //阴影的高度
      forceElevated: false,
      //拉满时是否显示阴影
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      //所有的icon的样式,不仅仅是左侧的，右侧的也会改变

      expandedHeight: 200.0,
      //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
      // floating: true, //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
      pinned: true,
      //是否固定导航栏
      // snap:false, //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
      flexibleSpace: new FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          _group.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        background: Stack(
          children: <Widget>[
            Image.network(
              _group.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(2),
                width: 74.0,
                height: 74.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: ClipOval(
                  child: ViewUtil.fadeImage(_group.avatarUrl),
                ),
              ),
            )
          ],
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }
}
