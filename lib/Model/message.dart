class Listmessage {
  var time;
  String? msgid;
  String? msg;
  List? users;
  String? sendidmsg;


  Listmessage(
      {
    required  this.time,
    required  this.sendidmsg,
    required  this.users,
    required  this.msgid,
    required  this.msg});

  Listmessage.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    msgid = json['msgid'];
    msg = json['msg'];
    users = json['users'];
    sendidmsg = json['sendidmsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['msgid'] = this.msgid;
    data['msg'] = this.msg;
    data['users'] = this.users;
     data['sendidmsg']=this.sendidmsg;

    return data;
  }
}