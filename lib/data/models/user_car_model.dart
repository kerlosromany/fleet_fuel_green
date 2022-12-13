class UserCar {
  String? message;
  Data? data;

  UserCar({this.message, this.data});

  UserCar.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<UserVehicles> userVehicles = [];

  //Data({required this.userVehicles});

  Data.fromJson(Map<String, dynamic> json) {
    //userVehicles = json['UserVehicles'];
    json['UserVehicles'].forEach((element) {
      userVehicles.add(UserVehicles.fromJson(element));
    });
  }
}

class UserVehicles {
  int? id;
  int? userId;
  int? vehicleId;
  String? vehicleType;
  String? vehicleCompany;
  String? color;
  String? purchaseYear;
  String? carNumber;
  int? currentUser;
  int? isApprove;
  List<dynamic>? driverImages;

  UserVehicles({
    this.id,
    this.userId,
    this.vehicleId,
    this.vehicleType,
    this.vehicleCompany,
    this.color,
    this.purchaseYear,
    this.carNumber,
    this.currentUser,
    this.isApprove,
    this.driverImages,
  });

  UserVehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    vehicleId = json['vehicle_id'];
    vehicleType = json['vehicle_type'];
    vehicleCompany = json['vehicle_company'];
    color = json['color'];
    purchaseYear = json['purchase_year'];
    carNumber = json['car_number'];
    currentUser = json['current_user'];
    isApprove = json['is_approve'];
    driverImages = json['driverImages'];
  }
}
