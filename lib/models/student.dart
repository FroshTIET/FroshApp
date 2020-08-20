class Student {
  String id;
  User user;
  String rollNumber;
  String fullName;
  String branch;
  String gender;
  String birthday;
  int points;
  String phoneNumber;

  Student(
      {this.id,
      this.user,
      this.rollNumber,
      this.fullName,
      this.branch,
      this.gender,
      this.birthday,
      this.points,
      this.phoneNumber});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rollNumber = json['rollNumber'];
    fullName = json['fullName'];
    branch = json['branch'];
    gender = json['gender'];
    birthday = json['birthday'];
    points = json['points'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['rollNumber'] = this.rollNumber;
    data['fullName'] = this.fullName;
    data['branch'] = this.branch;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['points'] = this.points;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}

class User {
  String username;
  String firstName;
  String lastName;
  String email;

  User({this.username, this.firstName, this.lastName, this.email});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}
