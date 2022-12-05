class LoginModel {
  String? message;
  Data? data;

  LoginModel({this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  User? user;
  String? otp;

  Data({this.user, this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    otp = json['otp'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.user != null) {
  //     data['user'] = this.user.toJson();
  //   }
  //   return data;
  // }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? nickName;
  String? birth;
  String? email;
  String? type;
  int? rate;
  String? image;
  List<dynamic>? driverImages;
  String? token;

  User({
    this.id,
    this.name,
    this.phone,
    this.nickName,
    this.birth,
    this.email,
    this.type,
    this.rate,
    this.image,
    this.driverImages,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    nickName = json['nickName'];
    birth = json['birth'];
    email = json['email'];
    type = json['type'];
    rate = json['rate'];
    image = json['image'];
    driverImages = json['driverImages'];
    token = json['token'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['phone'] = this.phone;
  //   data['nickName'] = this.nickName;
  //   data['birth'] = this.birth;
  //   data['email'] = this.email;
  //   data['type'] = this.type;
  //   data['rate'] = this.rate;
  //   data['image'] = this.image;
  //   if (this.driverImages != null) {
  //     data['driverImages'] = this.driverImages.map((v) => v.toJson()).toList();
  //   }
  //   data['token'] = this.token;
  //   return data;
  // }
}
