class Vehicle {
  final String nRegNew;
  final String vin;
  final String brand;
  final String model;
  final int makeYear;
  final String color;
  final String kind;
  final String body;
  final String fuel;
  final int capacity;
  final int ownWeight;
  final int totalWeight;

  Vehicle({
    required this.nRegNew,
    required this.vin,
    required this.brand,
    required this.model,
    required this.makeYear,
    required this.color,
    required this.kind,
    required this.body,
    required this.fuel,
    required this.capacity,
    required this.ownWeight,
    required this.totalWeight,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      nRegNew: json['n_reg_new'] as String? ?? '',
      vin: json['vin'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      model: json['model'] as String? ?? '',
      makeYear: json['make_year'] as int? ?? 0,
      color: json['color'] as String? ?? '',
      kind: json['kind'] as String? ?? '',
      body: json['body'] as String? ?? '',
      fuel: json['fuel'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      ownWeight: json['own_weight'] as int? ?? 0,
      totalWeight: json['total_weight'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n_reg_new': nRegNew,
      'vin': vin,
      'brand': brand,
      'model': model,
      'make_year': makeYear,
      'color': color,
      'kind': kind,
      'body': body,
      'fuel': fuel,
      'capacity': capacity,
      'own_weight': ownWeight,
      'total_weight': totalWeight,
    };
  }
}
