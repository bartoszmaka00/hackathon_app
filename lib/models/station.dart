class Station {
  int? startStation;
  int? finishStation;
  DateTime? startTime;
  DateTime? finishTime;
  Station(
      {required this.startStation,
      required this.finishStation,
      required this.startTime,
      required this.finishTime});
  factory Station.fromJson(Map<String, dynamic> body) {
    return Station(
        startStation: body['start_station'],
        finishStation: body['end_station'],
        startTime: DateTime.parse(body['created_at']),
        finishTime: DateTime.parse(body['updated_at']));
  }
}
