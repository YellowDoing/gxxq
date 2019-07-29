import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant.dart';
import 'page/page1.dart';
import 'page/page2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _changeStatuBar();
    return MaterialApp(
      title: '共享星球',
      theme: ThemeData(
          primaryColor: GREEN,
          accentColor: GREEN,
          scaffoldBackgroundColor: Color.fromARGB(255, 245, 246, 248)),
      home: MyHomePage(),
    );
  }

  //改变状态栏字体颜色
  _changeStatuBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  TabController controller; //底部导航控制器
  int _currentIndex = 0; //选中位置


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() => _onTabChanged());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Page1(),
          Page2(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  SafeArea _buildBottomNavigationBar() {
    return SafeArea(
      child: Container(
        height: 52,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: const Color(0xFFd0d0d0), blurRadius: 1.0)
        ]),
        child: TabBar(
          labelColor: GREEN,
          controller: controller,
          tabs: [
            _buildTab(
                '星球',
                _currentIndex == 0
                    ? 'assets/images/ic_groups_activated.png'
                    : 'assets/images/ic_groups.png'),
            _buildTab(
                '我的',
                _currentIndex == 1
                    ? 'assets/images/ic_me_activated.png'
                    : 'assets/images/ic_me.png')
          ],
          indicator: const BoxDecoration(),
          unselectedLabelColor: Color(0xFF888888),
        ),
      ),
    );
  }

  Tab _buildTab(String tabName, String tabRes) {
    return Tab(
        child: Text(
          tabName,
          style: TextStyle(fontSize: 12),
        ),
        icon: Image.asset(tabRes, width: 28, height: 28));
  }

  /*
      底部导航点击事件
   */
  _onTabChanged() {
    if (controller.indexIsChanging) {
      if (this.mounted) {
        this.setState(() {
          _currentIndex = controller.index;
        });
      }
    }
  }


}
