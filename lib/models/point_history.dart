import 'package:flutter/material.dart';
import 'dart:core';

class PointHistory {
  int points = 0;
  String creationTime = '';
  String transportationType = '';
  PointHistory(
      {required this.points,
      required this.creationTime,
      required this.transportationType});
  factory PointHistory.fromJson(Map<String, dynamic> body) {
    return PointHistory(
        points: body['points'],
        creationTime: body['created_at'],
        transportationType: body['category']);
  }
}
