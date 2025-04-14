class Pin {
  final int numberOfPeople;
  final int hostUserId;
  final String pin;
  final double latitude;
  final double longitude;
  final int expireAtMinutes;
  final List<int> groupsId;

  Pin({
    required this.numberOfPeople,
    required this.hostUserId,
    required this.pin,
    required this.latitude,
    required this.longitude,
    required this.expireAtMinutes,
    required this.groupsId,
  });

  factory Pin.fromJson(Map<String, dynamic> json) {
    return Pin(
      numberOfPeople: json['numberOfPeople'],
      hostUserId: json['numberOfPeople'],
      pin: json['pin'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      expireAtMinutes: json['expireAtMinutes'],
      groupsId: List<int>.from(json['groupsId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numberOfPeople': numberOfPeople,
      'hostUserId': hostUserId,
      'pin': pin,
      'latitude': latitude,
      'longitude': longitude,
      'expireAtMinutes': expireAtMinutes,
      'groupsId': groupsId,
    };
  }
}
