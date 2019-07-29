import 'package:flutter/material.dart';
import '../model/topic_image.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPreview extends StatelessWidget {
  final List<TopicImage> _list;
  final int currentIndex;

  PhotoPreview(this._list, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: PageView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: PhotoView(
              onTapUp: (context, details, controllerValue) {
                Navigator.pop(context);
              },
              imageProvider: NetworkImage(_list[index].large.url),
            ),
          );
        },
        itemCount: _list.length,
        controller: PageController(initialPage: currentIndex),
      ),
    );
  }
}
