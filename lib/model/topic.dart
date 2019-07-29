

import '../model/topic_image.dart';

class Topic {
  int topicId;
  IGroup group;
  String type;
  Talk talk;
  List<LatestLikes> latestLikes;
  List<ShowComments> showComments;
  int likesCount;
  int rewardsCount;
  int commentsCount;
  int readingCount;
  bool digested;
  bool sticky;
  String createTime;
  UserSpecific userSpecific;
  Question question;
  Answer answer;

  Topic({this.topicId,
    this.group,
    this.type,
    this.talk,
    this.latestLikes,
    this.showComments,
    this.likesCount,
    this.rewardsCount,
    this.commentsCount,
    this.readingCount,
    this.digested,
    this.sticky,
    this.createTime,
    this.question,
    this.answer,
    this.userSpecific});

  Topic.fromJson(Map<String, dynamic> json) {
    if (json['topic_id'] != null)
      topicId = json['topic_id'];
    group = json['group'] != null ? new IGroup.fromJson(json['group']) : null;
    type = json['type'];
    talk = json['talk'] != null ? new Talk.fromJson(json['talk']) : null;
    if (json['latest_likes'] != null) {
      latestLikes = new List<LatestLikes>();
      json['latest_likes'].forEach((v) {
        latestLikes.add(new LatestLikes.fromJson(v));
      });
    }
    if (json['show_comments'] != null) {
      showComments = new List<ShowComments>();
      json['show_comments'].forEach((v) {
        showComments.add(new ShowComments.fromJson(v));
      });
    }
    likesCount = json['likes_count'];
    rewardsCount = json['rewards_count'];
    commentsCount = json['comments_count'];
    readingCount = json['reading_count'];
    digested = json['digested'];
    sticky = json['sticky'];
    createTime = json['create_time'];
    userSpecific = json['user_specific'] != null
        ? new UserSpecific.fromJson(json['user_specific'])
        : null;

    answer =
    json['answer'] != null ? new Answer.fromJson(json['answer']) : null;

    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_id'] = this.topicId;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    data['type'] = this.type;
    if (this.talk != null) {
      data['talk'] = this.talk.toJson();
    }
    if (this.latestLikes != null) {
      data['latest_likes'] = this.latestLikes.map((v) => v.toJson()).toList();
    }
    if (this.showComments != null) {
      data['show_comments'] = this.showComments.map((v) => v.toJson()).toList();
    }
    data['likes_count'] = this.likesCount;
    data['rewards_count'] = this.rewardsCount;
    data['comments_count'] = this.commentsCount;
    data['reading_count'] = this.readingCount;
    data['digested'] = this.digested;
    data['sticky'] = this.sticky;
    data['create_time'] = this.createTime;
    if (this.userSpecific != null) {
      data['user_specific'] = this.userSpecific.toJson();
    }
    return data;
  }
}

class IGroup {
  int groupId;
  String name;

  IGroup({this.groupId, this.name});

  IGroup.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['name'] = this.name;
    return data;
  }
}

class Talk {
  Owner owner;
  String text;
  List<TopicImage> images;
  List<File> files;

  Talk({this.owner, this.text});

  Talk.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    text = json['text'];
    if (json['images'] != null) {
      images = new List<TopicImage>();
      json['images'].forEach((v) {
        images.add(new TopicImage.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = new List<File>();
      json['files'].forEach((v) {
        files.add(new File.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['text'] = this.text;
    return data;
  }
}

class File {
  int fileId;
  String name;
  String hash;
  int size;
  int downloadCount;
  String createTime;
  int duration;

  File({this.fileId,
    this.name,
    this.hash,
    this.size,
    this.downloadCount,
    this.createTime,
    this.duration});

  File.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
    name = json['name'];
    hash = json['hash'];
    size = json['size'];
    downloadCount = json['download_count'];
    createTime = json['create_time'];
    duration = json['duration'];
  }
}

class Owner {
  int userId;
  String name;
  String avatarUrl;

  Owner({this.userId, this.name, this.avatarUrl});

  Owner.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}

class LatestLikes {
  String createTime;
  Owner owner;

  LatestLikes({this.createTime, this.owner});

  LatestLikes.fromJson(Map<String, dynamic> json) {
    createTime = json['create_time'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.createTime;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}

class ShowComments {
  int commentId;
  String createTime;
  Owner owner;
  String text;
  int likesCount;
  int rewardsCount;
  Owner repliee;

  ShowComments({this.commentId,
    this.createTime,
    this.owner,
    this.text,
    this.likesCount,
    this.rewardsCount,
    this.repliee});

  ShowComments.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    createTime = json['create_time'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    text = json['text'];
    likesCount = json['likes_count'];
    rewardsCount = json['rewards_count'];
    repliee =
    json['repliee'] != null ? new Owner.fromJson(json['repliee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['create_time'] = this.createTime;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['text'] = this.text;
    data['likes_count'] = this.likesCount;
    data['rewards_count'] = this.rewardsCount;
    if (this.repliee != null) {
      data['repliee'] = this.repliee.toJson();
    }

    return data;
  }
}

class UserSpecific {
  bool liked;
  bool subscribed;

  UserSpecific({this.liked, this.subscribed});

  UserSpecific.fromJson(Map<String, dynamic> json) {
    liked = json['liked'];
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liked'] = this.liked;
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class Answer {
  Owner owner;
  String text;

  Answer({this.owner, this.text});

  Answer.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;

    text = json['text'];
  }
}

class Question {
  Owner questionee;
  Owner owner;
  String text;
  bool expired;
  bool anonymous;

  Question(
      {this.questionee, this.text, this.expired, this.anonymous, this.owner});

  Question.fromJson(Map<String, dynamic> json) {
    questionee = json['questionee'] != null
        ? new Owner.fromJson(json['questionee'])
        : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;

    text = json['text'];
    expired = json['expired'];
    anonymous = json['anonymous'];
  }
}
