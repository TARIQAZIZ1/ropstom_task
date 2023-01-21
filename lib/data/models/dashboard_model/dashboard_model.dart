// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DashboardModel dashboardModelFromJson(int id, String str) => DashboardModel.fromJson(id, json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    this.id,
    required this.carName,
    required this.carModel,
    required this.carColor,
    required this.ownerName,
  });

  final int? id;
  final String carName;
  final String carModel;
  final String carColor;
  final String ownerName;

  factory DashboardModel.fromJson(int id, Map<String, dynamic> json) => DashboardModel(
    id: id.toInt(),
    carName: json["car_name"].toString(),
    carModel: json["car_model"].toString(),
    carColor: json["car_color"].toString(),
    ownerName: json["owner_name"].toString(),
  );

   Map<String, dynamic> toJson() => {
    "car_name": carName,
    "car_model": carModel,
    "car_color": carColor,
    "owner_name": ownerName,
  };
}
