class Store {
  String? name;
  var time;
  String? price;
  String? urlimage;
  String? uid;
  String? username;
  String? userphoto;
  String? details;
  String? id;

  Store(
      {this.name,
      this.time,
      this.price,
      this.urlimage,
      this.uid,
      this.username,
      this.userphoto,
      this.details,
      this.id});

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
    price = json['price'];
    urlimage = json['urlimage'];
    uid = json['uid'];
    username = json['username'];
    userphoto = json['userphoto'];
    details = json['details'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time'] = this.time;
    data['price'] = this.price;
    data['urlimage'] = this.urlimage;
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['userphoto'] = this.userphoto;
    data['details'] = this.details;
    data['id'] = this.id;
    return data;
  }
}