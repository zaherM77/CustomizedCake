class CustomizationDetails {
  final int id;
  final String color;
  final int numberOfLayers;
  final String flavour;
  final String frosting;
  final String cakeTopper;

  CustomizationDetails({
    required this.id,
    required this.color,
    required this.numberOfLayers,
    required this.flavour,
    required this.frosting,
    required this.cakeTopper,
  });

  factory CustomizationDetails.fromJson(Map<String, dynamic> json) {
    return CustomizationDetails(
      id: int.parse(json['id'].toString()),
      color: json['color'] as String,
      numberOfLayers: int.parse(json['nb_of_layers'].toString()),
      flavour: json['flavour'] as String,
      frosting: json['frosting'] as String,
      cakeTopper: json['cake_topper'] as String,
    );
  }
}