import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';

class DaysOfUseField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFieldEmpty;

  const DaysOfUseField({
    required this.controller,
    required this.isFieldEmpty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      forceErrorText: isFieldEmpty ? 'Informe uma quantidade.' : null,
      controller: controller,
      style: TextStyle(fontSize: 20),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: NewMedicineFormStyle.roundedInputDecoration(
        'Digite os dias',
        Icon(
          Icons.calendar_today,
          color: kPrimaryColor,
          size: NewMedicineFormStyle.iconSize,
        ),
      ).copyWith(errorStyle: TextStyle(fontSize: 18)),
      autofocus: false,
    );
  }
}
