import 'package:flutter/material.dart';
import 'dart:core';

class PointHistory {
  int points = 0;
  String creationTime = '';
  PointHistory({required this.points, required this.creationTime});
  factory PointHistory.fromJson(Map<String, dynamic> body) {
    return PointHistory(
        points: body['points'], creationTime: body['created_at']);
  }
}
