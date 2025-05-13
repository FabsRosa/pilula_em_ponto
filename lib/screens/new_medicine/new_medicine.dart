import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pilula_em_ponto/data/models/medicine.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/screens/new_medicine/first_screen.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/new_medicine_form_data.dart';

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

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref
          .read(medicinesProvider.notifier)
          .addMedicine(Medicine(name: _formData.nameController.text));

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FirstScreen(saveForm: _saveForm, formData: _formData),
    );
  }
}
