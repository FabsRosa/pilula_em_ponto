import 'package:flutter/material.dart';

class NewMedicineFormData with ChangeNotifier {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
