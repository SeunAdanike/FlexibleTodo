class UserDetails {
  int id;
  String userName;

  userMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['userName'] = userName;
    return map;
  }
}
