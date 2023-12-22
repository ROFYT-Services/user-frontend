class CabClass {
  int id;
  double price;
  String cabClassName;
  String cabClassIcon;
  int platformCharge;

  CabClass({
    required this.id,
    required this.price,
    required this.cabClassName,
    required this.cabClassIcon,
    required this.platformCharge,
  });

  factory CabClass.fromJson(Map<String, dynamic> json) {
    return CabClass(
      // id: json['cab_class'] as int,
      id: json['cab_class']['id'] as int,
      price: json['price'] as double,
      // cabClassName: json['cab_class_name'] as String,
      cabClassName: json['cab_class']['cab_class'] as String,
      // cabClassIcon: json['cab_class_icon'] as String,
      cabClassIcon: json['cab_class']['icon'] as String,
      platformCharge: json['platform_charge'] as int,
    );
  }
}
