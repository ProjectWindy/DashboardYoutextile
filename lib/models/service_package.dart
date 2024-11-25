class ServicePackage {
  final String uuid;
  final String name;
  final String shortDescription;
  final String originalPrice;
  final String? discountPrice;
  final String? discountPercentage;
  final int duration;
  final String status;

  ServicePackage({
    required this.uuid,
    required this.name,
    required this.shortDescription,
    required this.originalPrice,
    this.discountPrice,
    this.discountPercentage,
    required this.duration,
    required this.status,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      shortDescription: json['short_description'] ?? '',
      originalPrice: json['original_price'] ?? '0',
      discountPrice: json['discount_price'],
      discountPercentage: json['discount_percentage'],
      duration: json['duration'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class ServicePackageResponse {
  final String message;
  final List<ServicePackage> servicePackages;

  ServicePackageResponse({
    required this.message,
    required this.servicePackages,
  });

  factory ServicePackageResponse.fromJson(Map<String, dynamic> json) {
    return ServicePackageResponse(
      message: json['message'] ?? '',
      servicePackages: (json['service_packages'] as List?)
              ?.map((e) => ServicePackage.fromJson(e))
              .toList() ??
          [],
    );
  }
} 