import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gxxq/view/photo_preview.dart';
import '../model/topic_image.dart';

class TopicImages {
  static double screenWidth;

  //单图
  static Widget singleImage(List<TopicImage> topicImages,
      BuildContext context) {
    double width;
    //宽高比
    double ratio =
        topicImages[0].thumbnail.height / topicImages[0].thumbnail.width;
    if (ratio >= 2) {
      //竖直长方形
      width = 75;
    } else if (ratio <= 0.75) {
      //横长方形
      width = double.infinity;
    } else {
      //正方形
      width = 150;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PhotoPreview(topicImages, 0);
        }));
      },
      child: Image.network(
        topicImages[0].thumbnail.url,
        height: 150,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  //双图
  static Widget doubleImage(List<TopicImage> images, BuildContext context) {
    int verNum = 0; //是否显示竖图
    images.forEach((ti) {
      double ratio = ti.thumbnail.height / ti.thumbnail.width;
      if (ratio >= 2) verNum++;
    });

    return Wrap(
      spacing: 4,
      children: _renderImages(images, (index) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PhotoPreview(images, index);
        }));
      },
          width: verNum == 2 ? 75 : 100, height: verNum == 2 ? 75 : 100),
    );
  }

  //四图
  static Widget fourImages(List<TopicImage> images, BuildContext context) {
    final secondWrap = List<TopicImage>();
    var i3 = images[2];
    var i4 = images[3];
    images.remove(i3);
    images.remove(i4);
    secondWrap.add(i3);
    secondWrap.add(i4);
    return Wrap(
      spacing: 4,
      direction: Axis.vertical,
      children: <Widget>[
        Wrap(
          spacing: 4,
          children: _renderImages(images, (index) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              var i = images;
              i.addAll(secondWrap);
              return PhotoPreview(i, index);
            }));
          }, width: 75, height: 75),
        ),
        Wrap(
          spacing: 4,
          children: _renderImages(secondWrap, (index) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              var i = images;
              i.addAll(secondWrap);
              return PhotoPreview(i, index + 2);
            }));
          }, width: 75, height: 75),
        ),
      ],
    );
  }

  //多图 3 5 6 7 8 9
  static Widget multiImages(List<TopicImage> images, BuildContext context) {
    return Wrap(
      spacing: 4,
      children: _renderImages(images, (index) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PhotoPreview(images, index);
        }));
      }, width: 75, height: 75),
    );
  }

  static _renderImages(List<TopicImage> images, void Function(int index) taped,
      {double width, double height}) {
    return images.map((topicImage) {
      return GestureDetector(
        onTap: () {
          taped(images.indexOf(topicImage));
        },
        child: Image.network(
          topicImage.thumbnail.url,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    }).toList();
  }
}
