enum TransportationType {
  bus,
  train,
  bike,
  tram,
  metro,
  food,
  clothes,
  unknown
}

class Station {
  int? startStation;
  int? finishStation;
  DateTime? startTime;
  DateTime? finishTime;
  String transportationType;
  Station({
    required this.startStation,
    required this.finishStation,
    required this.startTime,
    required this.finishTime,
    required this.transportationType,
  });
  factory Station.fromJson(Map<String, dynamic> body) {
    return Station(
        startStation: body['start_station'],
        finishStation: body['end_station'],
        startTime: DateTime.parse(body['created_at']),
        finishTime: DateTime.parse(body['updated_at']),
        transportationType: body['travel_tool']);
  }
}
