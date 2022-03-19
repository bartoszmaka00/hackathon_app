class Privilege {
  String title;
  int duration;
  int price;
  int id;
  Privilege(
      {required this.title,
      required this.duration,
      required this.price,
      required this.id});
  factory Privilege.fromJson(Map<String, dynamic> body) {
    return Privilege(
        title: body['title'],
        duration: body['duration'],
        price: body['price'],
        id: body['id']);
  }
}
