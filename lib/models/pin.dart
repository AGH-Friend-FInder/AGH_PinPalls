class Pin {
  final int id;
  final int numberOfPeople;
  final String pin;
  final double latitude;
  final double longitude;
  final String expireAt;

  Pin({
    required this.id,
    required this.numberOfPeople,
    required this.pin,
    required this.latitude,
    required this.longitude,
    required this.expireAt,
  });

  factory Pin.fromJson(Map<String, dynamic> json) {
    return Pin(
      id: json['id'],
      numberOfPeople: json['numberOfPeople'],
      pin: json['pin'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      expireAt: json['expireAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number_of_people': numberOfPeople,
      'pin': pin,
      'latitude': latitude,
      'longitude': longitude,
      'expire_at': expireAt,
    };
  }
}
