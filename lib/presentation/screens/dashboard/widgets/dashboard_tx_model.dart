import 'package:flutter/material.dart';

class DashboardTxModel {
  const DashboardTxModel({
    required this.type,
    required this.iconPath,
    required this.iconColor,
    required this.iconBg,
    required this.time,
    required this.date,
    required this.amount,
    required this.isNegative,
  });
  final String type;
  final String iconPath;
  final Color iconColor;
  final Color iconBg;
  final String time;
  final String date;
  final String amount;
  final bool isNegative;
}
