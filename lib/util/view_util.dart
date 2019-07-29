import 'package:flutter/material.dart';

import '../constant.dart';

class ViewUtil {
  static Widget getAppBar(String title, BuildContext context,
      {bool leading = true, double elevation = 0.5, color = Colors.white}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
        leading: leading ? IconButton(
          icon: Image.asset(
            'assets/images/backgreen.png', width: 22, height: 22,),
          onPressed: () => Navigator.pop(context),
        ) : null,
        //iconTheme: IconThemeData(color: GREEN),
        //brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            color: GREEN,
          ),
        ),
        elevation: elevation,
        backgroundColor: color,
      ),

    )
    ;
  }

  static dismiss(BuildContext context) {
    Navigator.pop(context);
  }

  static loading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              padding: EdgeInsets.only(top: 25),
              color: Colors.white,
              width: 115,
              height: 115,
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: GestureDetector(
                      child: Text(
                        '加载中...',
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static Widget renderTextFiled(Icon icon,
      String hintText,
      ValueChanged<String> onChanged,
      Color borderColor,
      GestureTapCallback onTap,
      {obscureText = false,
        autoFocus = false, keyboardType = TextInputType.text}) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      width: 290,
      child: TextField(
        keyboardType: keyboardType,
        onTap: onTap,
        autofocus: autoFocus,
        onChanged: onChanged,
        maxLines: 1,
        decoration: InputDecoration(
            icon: icon,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14),
            labelStyle: TextStyle(fontSize: 14),
            border: InputBorder.none),
        obscureText: obscureText,
      ),
    );
  }


  static FadeInImage fadeImage(String url, {BoxFit fit}) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/ic_placeholder.png',
      image: url,
      fit: fit,
    );
  }

}
