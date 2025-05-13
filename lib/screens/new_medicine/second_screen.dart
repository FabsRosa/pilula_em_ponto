import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/name_field.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/type_field.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/new_medicine_form_data.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/new_medicine_form_style.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    super.key,
    required this.saveForm,
    required this.formData,
  });

  final void Function() saveForm;
  final NewMedicineFormData formData;

  Widget get _formContent {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Hero(
              tag: 'Imagem',
              child: Image.asset(
                'assets/images/new_medicine.png',
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Qual o tipo de medicamento?',
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            MedicineTypeField(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Novo Remédio',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          _formContent,
          NewMedicineFormStyle.nextButton(
            context: context,
            nextScreen: Placeholder(),
          ),
        ],
      ),
    );
  }
}
