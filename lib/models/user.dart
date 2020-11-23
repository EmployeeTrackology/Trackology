class TheUser {
  String uid;
  String name;
  String emailId;
  String password;
  String phone;

  TheUser({this.uid,this.name, this.emailId, this.password,this.phone});

  TheUser.fromMap(Map snapshot,String id) :
        uid = snapshot['uid'] ?? '',
        name = snapshot['name'] ?? '',
        emailId = snapshot['emailId'] ?? '',
        password = snapshot['password'] ?? '',
        phone =snapshot['phone'] ?? '';

  toJson() {
    return {
      "uid":uid,
      "name": name,
      "emailId" :emailId,
      "password" : password,
      "phone" : phone
    };
  }
}
