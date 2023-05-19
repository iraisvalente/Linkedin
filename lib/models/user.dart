class User {
  int? id;
  String firstname = "";
  String lastname = "";
  String email = "";
  String company = "";
  String position = "";
  String password = "";

  User(this.firstname, this.lastname, this.email, this.company, this.position,
      this.password);
  User.login(this.email);

  User.fromMap(dynamic obj) {
    firstname = obj['firstname'];
    lastname = obj['lastname'];
    email = obj['email'];
    company = obj['company'];
    position = obj['position'];
    password = obj['password'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['first_name'] = firstname;
    map['last_name'] = lastname;
    map['email'] = email;
    map['company'] = company;
    map['position'] = position;
    map['password'] = password;
    return map;
  }
}
