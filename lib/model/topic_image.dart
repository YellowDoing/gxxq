class TopicImage {
  int imageId;
  String type;
  Thumbnail thumbnail;
  Large large;
  Original original;

  TopicImage(
      {this.imageId, this.type, this.thumbnail, this.large, this.original});

  TopicImage.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    type = json['type'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    large = json['large'] != null ? new Large.fromJson(json['large']) : null;
    original = json['original'] != null
        ? new Original.fromJson(json['original'])
        : null;
  }

}

class Thumbnail {
  String url;
  int width;
  int height;

  Thumbnail({this.url, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }
}

class Large {
  String url;
  int width;
  int height;

  Large({this.url, this.width, this.height});

  Large.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }
}

class Original {
  String url;
  int width;
  int height;
  int size;

  Original({this.url, this.width, this.height, this.size});

  Original.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
  }
}
