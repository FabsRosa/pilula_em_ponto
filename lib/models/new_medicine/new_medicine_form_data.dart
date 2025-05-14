import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';

class NewMedicineFormData with ChangeNotifier {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final hourController = TextEditingController();
  final minuteController = TextEditingController(text: '00');
  final frequencyController = TextEditingController();
  final daysOfUseController = TextEditingController();
  MedicineType? medicineType;
  bool isLimitedTime = true;

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    hourController.dispose();
    minuteController.dispose();
    frequencyController.dispose();
    daysOfUseController.dispose();
    super.dispose();
  }
}
