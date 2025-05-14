import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';
import 'package:uuid/uuid.dart';

class Medicine {
  final String id;
  final String name;
  final TimeOfDay time;
  final int frequency;
  MedicineTypeId medicineType;
  final bool isActive;
  final bool isLimitedTime;
  final int? quantity;
  final int? daysOfUse;

  Medicine({
    required this.name,
    required this.time,
    required this.frequency,
    required this.medicineType,
    this.isActive = true,
    this.isLimitedTime = true,
    this.quantity,
    this.daysOfUse,
  }) : id = Uuid().v4();
}
