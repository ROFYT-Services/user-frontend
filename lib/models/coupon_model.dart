class CouponModel {
  int id;
  String couponCode;
  int couponDiscount;
  bool isActive;
  DateTime expireDate;
  String image;

  CouponModel({
    required this.id,
    required this.couponCode,
    required this.couponDiscount,
    required this.isActive,
    required this.expireDate,
    required this.image,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      couponCode: json['coupon_code'],
      couponDiscount: json['coupon_discount'],
      isActive: json['is_active'],
      expireDate: DateTime.parse(json['expire_date']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount,
      'is_active': isActive,
      'expire_date': expireDate.toIso8601String(),
      'image': image,
    };
  }
}
