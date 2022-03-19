class Privilege {
  String title;
  int duration;
  int price;
  Privilege({required this.title, required this.duration, required this.price});
  factory Privilege.fromJson(Map<String, dynamic> body) {
    return Privilege(
        title: body['title'], duration: body['duration'], price: body['price']);
  }
}
