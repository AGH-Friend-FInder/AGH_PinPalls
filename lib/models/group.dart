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

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      color: json['color'],
      groupName: json['groupName'],
      isPublic: json['isPublic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'group_name': groupName,
      'is_public': isPublic,
    };
  }
}
