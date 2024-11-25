class ShippingUnit {
  final String uuid;
  final String image;
  final String name;
  final String status;

  ShippingUnit({
    required this.uuid,
    required this.image,
    required this.name,
    required this.status,
  });

  // Từ JSON sang model
  factory ShippingUnit.fromJson(Map<String, dynamic> json) {
    return ShippingUnit(
      uuid: json['uuid'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
    );
  }

  // Từ model sang JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'image': image,
      'name': name,
      'status': status,
    };
  }
}
