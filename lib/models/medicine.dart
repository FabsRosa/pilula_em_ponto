import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';
import 'package:uuid/uuid.dart';

class Medicine {
  final String id;
  final String name;
  final int frequency;
  MedicineTypeId medicineType;
  bool isActive;
  final bool isContinuous;
  final TimeOfDay firstUseTime;
  final DateTime firstUseDate;
  final int? quantity;
  final int? daysOfUse;

  DateTime? nextAlarmDate;
  TimeOfDay? nextAlarmTime;
  int? daysLeft;

  String formattedDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month';
  }

  String formattedTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Medicine({
    required this.name,
    required this.frequency,
    required this.medicineType,
    required this.firstUseTime,
    required this.firstUseDate,
    this.isActive = true,
    this.isContinuous = true,
    this.quantity,
    this.daysOfUse,
    this.daysLeft,
    this.nextAlarmDate,
    this.nextAlarmTime,
  }) : id = Uuid().v4() {
    updateNextAlarm();
  }

  void updateNextAlarm() {
    if (!isActive) return;

    final currentDateTime = DateTime.now();

    // Handle non-continuous case validation and daysLeft calculation
    if (!isContinuous) {
      if (daysOfUse == null) {
        isActive = false;
        daysLeft = 0;
        nextAlarmDate = null;
        nextAlarmTime = null;
        return;
      }

      final endDate = firstUseDate.add(Duration(days: daysOfUse!));
      if (currentDateTime.isAfter(endDate) ||
          currentDateTime.isAtSameMomentAs(endDate)) {
        isActive = false;
        daysLeft = 0;
        nextAlarmDate = null;
        nextAlarmTime = null;
        return;
      }

      final daysPassed = currentDateTime.difference(firstUseDate).inDays;
      daysLeft = daysOfUse! - daysPassed;
      if (daysLeft! < 0) {
        isActive = false;
        daysLeft = 0;
        nextAlarmDate = null;
        nextAlarmTime = null;
        return;
      }
    }

    // Calculate first alarm DateTime
    final firstAlarmDateTime = DateTime(
      firstUseDate.year,
      firstUseDate.month,
      firstUseDate.day,
      firstUseTime.hour,
      firstUseTime.minute,
    );

    // Handle case where current time is before first alarm
    if (currentDateTime.isBefore(firstAlarmDateTime)) {
      nextAlarmDate = firstAlarmDateTime;
      nextAlarmTime = TimeOfDay.fromDateTime(firstAlarmDateTime);
      return;
    }

    // Calculate interval duration
    final intervalHours = 24.0 / frequency;
    final hours = intervalHours.truncate();
    final minutes = ((intervalHours - hours) * 60).round();
    final intervalDuration = Duration(hours: hours, minutes: minutes);

    // Calculate number of intervals passed
    final difference = currentDateTime.difference(firstAlarmDateTime);
    final intervalsPassed =
        difference.inMicroseconds / intervalDuration.inMicroseconds;
    var nextInterval = intervalsPassed.floor() + 1;

    // Calculate next alarm DateTime
    var nextAlarmDateTime = firstAlarmDateTime.add(
      intervalDuration * nextInterval,
    );

    // Ensure next alarm is after current time (handle edge cases)
    while (nextAlarmDateTime.isBefore(currentDateTime)) {
      nextInterval++;
      nextAlarmDateTime = firstAlarmDateTime.add(
        intervalDuration * nextInterval,
      );
    }

    // Validate against end date for non-continuous
    if (!isContinuous) {
      final endDate = firstUseDate.add(Duration(days: daysOfUse!));
      if (nextAlarmDateTime.isAfter(endDate) ||
          nextAlarmDateTime.isAtSameMomentAs(endDate)) {
        isActive = false;
        daysLeft = 0;
        nextAlarmDate = null;
        nextAlarmTime = null;
        return;
      }
    }

    // Update next alarm properties
    nextAlarmDate = nextAlarmDateTime;
    nextAlarmTime = TimeOfDay.fromDateTime(nextAlarmDateTime);
  }

  Medicine copyWith({
    String? name,
    int? frequency,
    MedicineTypeId? medicineType,
    bool? isActive,
    bool? isContinuous,
    TimeOfDay? firstUseTime,
    DateTime? firstUseDate,
    int? quantity,
    int? daysOfUse,
    int? daysLeft,
    DateTime? nextAlarmDate,
    TimeOfDay? nextAlarmTime,
  }) {
    return Medicine(
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      medicineType: medicineType ?? this.medicineType,
      firstUseTime: firstUseTime ?? this.firstUseTime,
      firstUseDate: firstUseDate ?? this.firstUseDate,
      isActive: isActive ?? this.isActive,
      isContinuous: isContinuous ?? this.isContinuous,
      quantity: quantity ?? this.quantity,
      daysOfUse: daysOfUse ?? this.daysOfUse,
      daysLeft: daysLeft ?? this.daysLeft,
      nextAlarmDate: nextAlarmDate ?? this.nextAlarmDate,
      nextAlarmTime: nextAlarmTime ?? this.nextAlarmTime,
    );
  }
}
