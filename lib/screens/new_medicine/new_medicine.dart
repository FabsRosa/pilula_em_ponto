import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pilula_em_ponto/models/medicine.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/screens/new_medicine/form_screens/first_screen.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_data.dart';

class NewMedicineScreen extends StatelessWidget {
  const NewMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _NewMedicineContent();
  }
}

class _NewMedicineContent extends ConsumerStatefulWidget {
  const _NewMedicineContent();

  @override
  ConsumerState<_NewMedicineContent> createState() =>
      _NewMedicineContentState();
}

class _NewMedicineContentState extends ConsumerState<_NewMedicineContent> {
  final _formKey = GlobalKey<FormState>();
  final _formData = NewMedicineFormData();

  DateTime get _firstUseDate {
    final now = DateTime.now();
    final firstUseTime = TimeOfDay(
      hour: int.parse(_formData.hourController.text),
      minute: int.parse(_formData.minuteController.text),
    );
    final firstUseDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      firstUseTime.hour,
      firstUseTime.minute,
    );
    return firstUseDateTime.isBefore(now)
        ? firstUseDateTime.add(const Duration(days: 1))
        : firstUseDateTime;
  }

  void _saveForm() {
    _formKey.currentState!.save();
    ref
        .read(medicinesProvider.notifier)
        .addMedicine(
          Medicine(
            name: _formData.nameController.text,
            frequency: int.parse(_formData.frequencyController.text),
            medicineType: _formData.medicineType!.id,
            firstUseTime: TimeOfDay(
              hour: int.parse(_formData.hourController.text),
              minute: int.parse(_formData.minuteController.text),
            ),
            quantity: int.tryParse(_formData.frequencyController.text),
            isContinuous: _formData.isContinuous,
            daysOfUse: int.tryParse(_formData.daysOfUseController.text),
            firstUseDate: _firstUseDate,
          ),
        );

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  bool _validateForm() {
    return _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FirstScreen(
        formKey: _formKey,
        saveForm: _saveForm,
        validateForm: _validateForm,
        formData: _formData,
      ),
    );
  }
}
