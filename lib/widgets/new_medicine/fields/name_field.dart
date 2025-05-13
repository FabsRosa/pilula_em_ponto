import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

import 'package:pilula_em_ponto/widgets/new_medicine/new_medicine_form_style.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      controller: controller,
      style: TextStyle(fontSize: 20),
      decoration: NewMedicineFormStyle.roundedInputDecoration(
        'Digite o nome',
        Icon(
          Icons.medication,
          color: kPrimaryColor,
          size: NewMedicineFormStyle.iconSize,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length > 50) {
          return 'Digite o nome do remédio.';
        }
        return null;
      },
    );
  }
}
