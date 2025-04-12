class Group {
  final int id;
  final String color;
  final String groupName;
  final bool isPublic;

  Group({
    required this.id,
    required this.color,
    required this.groupName,
    required this.isPublic,
  });

  // Factory method to create a Group from a JSON map
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      color: json['color'],
      groupName: json['groupName'],
      isPublic: json['isPublic'],
    );
  }

  // Method to convert a Group instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'groupName': groupName,
      'isPublic': isPublic,
    };
  }
}
