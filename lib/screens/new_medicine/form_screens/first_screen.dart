import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/screens/new_medicine/form_screens/second_screen.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/name_field.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_data.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({
    super.key,
    required this.saveForm,
    required this.validateForm,
    required this.formKey,
    required this.formData,
  });

  final void Function() saveForm;
  final bool Function() validateForm;
  final GlobalKey<FormState> formKey;
  final NewMedicineFormData formData;

  bool validator() {
    validateForm();
    return formData.nameController.text.isNotEmpty;
  }

  Widget get _formContent {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Hero(
              tag: 'Imagem',
              child: Image.asset(
                'assets/images/green_medicine_new.png',
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Qual o nome do medicamento?',
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            NameField(controller: formData.nameController),
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
      body: Column(
        children: [
          Expanded(child: _formContent),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NewMedicineFormStyle.nextButtonNotPositioned(
                context: context,
                color: kPrimaryColor,
                nextScreen:
                    () => SecondScreen(
                      saveForm: saveForm,
                      validateForm: validateForm,
                      formData: formData,
                      formKey: formKey,
                    ),
                validateForm: validator,
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 45),
        ],
      ),
    );
  }
}
