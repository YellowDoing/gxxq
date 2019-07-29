class Comment {
  int commentId;
  String createTime;
  Owner owner;
  String text;
  int likesCount;
  int rewardsCount;
  int repliesCount;
  List<RepliedComments> repliedComments;

  Comment({this.commentId,
    this.createTime,
    this.owner,
    this.text,
    this.likesCount,
    this.rewardsCount,
    this.repliesCount,
    this.repliedComments});

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    createTime = json['create_time'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    text = json['text'];
    likesCount = json['likes_count'];
    rewardsCount = json['rewards_count'];
    repliesCount = json['replies_count'];
    if (json['replied_comments'] != null) {
      repliedComments = new List<RepliedComments>();
      json['replied_comments'].forEach((v) {
        repliedComments.add(new RepliedComments.fromJson(v));
      });
    }
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
    data['replies_count'] = this.repliesCount;
    if (this.repliedComments != null) {
      data['replied_comments'] =
          this.repliedComments.map((v) => v.toJson()).toList();
    }
    return data;
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

class RepliedComments {
  int commentId;
  String createTime;
  Owner owner;
  String text;
  int likesCount;
  int rewardsCount;
  Repliee repliee;

  RepliedComments({this.commentId,
    this.createTime,
    this.owner,
    this.text,
    this.likesCount,
    this.rewardsCount,
    this.repliee});

  RepliedComments.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    createTime = json['create_time'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    text = json['text'];
    likesCount = json['likes_count'];
    rewardsCount = json['rewards_count'];
    repliee =
    json['repliee'] != null ? new Repliee.fromJson(json['repliee']) : null;
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

class Repliee {
  int userId;
  String name;
  String avatarUrl;

  Repliee({this.userId, this.name, this.avatarUrl});

  Repliee.fromJson(Map<String, dynamic> json) {
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
