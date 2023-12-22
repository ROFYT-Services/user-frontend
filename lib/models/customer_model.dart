class CustomerProfileModel {
  String firstName;
  String lastName;
  String phone;
  String email;
  String birthDay;
  String gender;

  String photoUpload;
  String code;
  double cabDiscount;
  int id;

  CustomerProfileModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.birthDay,
    required this.gender,
    required this.photoUpload,
    required this.id,
    required this.code,
    required this.cabDiscount,
  });

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileModel(
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      phone: json['phone'] ?? "",
      email: json['email'] ?? "",
      birthDay: json['birth_day'] ?? "",
      gender: json['gender'] ?? "",
      photoUpload: json['photo_upload'] ?? "",
      code: json['code'] ?? "",
      cabDiscount: json['cab_discount'] ?? 0.0,
      id: json['id'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'birth_day': birthDay,
      'gender': gender,
      'photo_upload': photoUpload,
    };
  }
}
