class User {
  String name;
  int avartarId;

  User(this.name, this.avartarId);

  Map<String, dynamic> toJson() => {
        'name': name,
        'avartarId': avartarId,
      };
}
