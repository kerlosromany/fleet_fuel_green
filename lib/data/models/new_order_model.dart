class NewOrderModel {
  String? message;
  Data? data;

  NewOrderModel({this.message, this.data});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Order? order;
  String? paidApi;

  Data({this.order, this.paidApi});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    paidApi = json['paidApi'];
  }
}

class Order {
  int? id;
  String? date;
  String? vehicleId;
  String? odometerInput;
  String? odometerOcr;
  String? literInput;
  String? literOcr;
  Location? location;
  OcrImages? ocrImages;

  Order({
    this.id,
    this.date,
    this.vehicleId,
    this.odometerInput,
    this.odometerOcr,
    this.literInput,
    this.literOcr,
    this.location,
    this.ocrImages,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    vehicleId = json['vehicle_id'];
    odometerInput = json['odometer_input'];
    odometerOcr = json['odometer_ocr'];
    literInput = json['liter_input'];
    literOcr = json['liter_ocr'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    ocrImages =
        json['OcrImages'] != null ? OcrImages.fromJson(json['OcrImages']) : null;
  }
}

class Location {
  int? id;
  int? createdAt;
  String? createdAtStr;
  String? type;
  double? longitude;
  double? latitude;
  String? address;

  Location({
    this.id,
    this.createdAt,
    this.createdAtStr,
    this.type,
    this.longitude,
    this.latitude,
    this.address,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    createdAtStr = json['created_at_str'];
    type = json['type'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
  }
}

class OcrImages {
  String? odometerOcr;
  String? literOcr;

  OcrImages({this.odometerOcr, this.literOcr});

  OcrImages.fromJson(Map<String, dynamic> json) {
    odometerOcr = json['odometer_ocr'];
    literOcr = json['liter_ocr'];
  }
}






