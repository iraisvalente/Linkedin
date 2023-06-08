class Position {
  final String position;
  final String? count;

  Position(this.position, this.count);

  Position.fromJson(Map<String, dynamic> json)
      : position = json['Position'],
        count = json['Count'];

  Map<String, dynamic> toJson() {
    return {'Position': position, 'Count': count};
  }
}
