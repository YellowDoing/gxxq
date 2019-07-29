class Group {
  int id;
  String groupId;
  String image;
  String name;
  String auth;
  String color;
  String avatarUrl;


  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    image = json['image'];
    name = json['name'];
    auth = json['auth'];
    color = json['color'];
    avatarUrl = json['avatarUrl'];
  }
}
