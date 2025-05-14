import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';

class FrequencyField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFieldEmpty;

  const FrequencyField({
    required this.controller,
    required this.isFieldEmpty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      forceErrorText: isFieldEmpty ? 'Informe uma frequência.' : null,
      controller: controller,
      style: TextStyle(fontSize: 20),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: NewMedicineFormStyle.roundedInputDecoration(
        'Digite a frequência',
        Icon(
          Icons.repeat,
          color: kPrimaryColor,
          size: NewMedicineFormStyle.iconSize,
        ),
      ).copyWith(errorStyle: TextStyle(fontSize: 18)),
      autovalidateMode: AutovalidateMode.onUnfocus,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite a frequência.';
        }
        return null;
      },
    );
  }
}
