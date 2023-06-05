class Connection {
  String firstname = "";
  String lastname = "";
  String email = "";
  String company = "";
  String position = "";
  String connection = "";

  Connection(this.firstname, this.lastname, this.email, this.company,
      this.position, this.connection);

  Connection.fromMap(dynamic obj) {
    firstname = obj['firstname'];
    lastname = obj['lastname'];
    email = obj['email'];
    company = obj['company'];
    position = obj['position'];
    connection = obj['connection'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['first_name'] = firstname;
    map['last_name'] = lastname;
    map['email'] = email;
    map['company'] = company;
    map['position'] = position;
    map['connection'] = connection;
    return map;
  }
}
