class UserPrivilege {
  int id;
  int duration;
  UserPrivilege({required this.id, required this.duration});
  factory UserPrivilege.fromJson(Map<String, dynamic> body) {
    return UserPrivilege(
      id: body['prize_id'],
      duration: body['duration_left'],
    );
  }
}
