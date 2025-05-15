import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 20),
      decoration: NewMedicineFormStyle.roundedInputDecoration(
        'Digite o nome',
        Icon(
          Icons.medical_services,
          color: kPrimaryColorBrighter,
          size: NewMedicineFormStyle.iconSize,
        ),
      ).copyWith(
        errorStyle: TextStyle(fontSize: 18), // Set the font size for error text
      ),
      autovalidateMode: AutovalidateMode.onUnfocus,
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length > 50) {
          return 'Informe o nome do remédio.';
        }
        return null;
      },
    );
  }
}
