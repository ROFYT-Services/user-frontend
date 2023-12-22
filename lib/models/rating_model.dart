class TripRating {
  bool isActive;
  double star;
  String feedback;
  int trip;

  TripRating({
    required this.isActive,
    required this.star,
    required this.feedback,
    required this.trip,
  });

  factory TripRating.fromJson(Map<String, dynamic> json) {
    return TripRating(
      isActive: json['is_active'] ?? false,
      star: json['star']?.toDouble() ?? 0.0,
      feedback: json['feedback'] ?? '',
      trip: json['trip'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['star'] = this.star;
    data['feedback'] = this.feedback;
    data['trip'] = this.trip;
    return data;
  }
}
