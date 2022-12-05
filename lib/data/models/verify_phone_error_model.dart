class VerifyPhoneErrorModel {
  String? message;
  List<dynamic>? data;

  VerifyPhoneErrorModel({this.message, this.data});

  VerifyPhoneErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}