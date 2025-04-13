class Pin {
  final int numberOfPeople;
  final String pin;
  final double latitude;
  final double longitude;

  final int? id;
  final int? hostUserId;
  final String? expireAt;
  final int? expireAtMinutes;
  final List<int>? groupsId;

  Pin({
    required this.numberOfPeople,
    required this.pin,
    required this.latitude,
    required this.longitude,

    this.id,
    this.expireAtMinutes,
    this.expireAt,
    this.hostUserId,
    this.groupsId,
  });

  factory Pin.fromJson(Map<String, dynamic> json) {
    return Pin(
      // hostUserId: json['hostUserId'],
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
      'numberOfPeople': numberOfPeople,
      'pin': pin,
      'latitude': latitude,
      'longitude': longitude,
      'expireAtMinutes': expireAtMinutes,
      'hostUserId': hostUserId,
      'groupsId': groupsId,
    };
  }
}
