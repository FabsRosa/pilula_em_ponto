import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';

class HourField extends StatelessWidget {
  final TextEditingController hourController;
  final TextEditingController minuteController;
  final bool isHourFieldEmpty;
  final bool isMinuteFieldEmpty;

  const HourField({
    required this.hourController,
    required this.minuteController,
    required this.isHourFieldEmpty,
    required this.isMinuteFieldEmpty,
    super.key,
  });

  Widget get _fullField {
    return Row(
      children: [
        Expanded(child: _hourField),
        const SizedBox(width: 16),
        Expanded(child: _minuteField),
      ],
    );
  }

  Widget get _hourField {
    return TextFormField(
      forceErrorText: isHourFieldEmpty ? 'Informe' : null,
      controller: hourController,
      style: TextStyle(fontSize: 20),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: NewMedicineFormStyle.roundedInputDecoration(
        'Hora',
        Icon(
          Icons.access_time,
          color: kPrimaryColor,
          size: NewMedicineFormStyle.iconSize,
        ),
      ).copyWith(errorStyle: TextStyle(fontSize: 17)),
      autofocus: false,
    );
  }

  Widget get _minuteField {
    return TextFormField(
      forceErrorText: isMinuteFieldEmpty ? 'Informe' : null,
      controller: minuteController,
      style: TextStyle(fontSize: 20),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: NewMedicineFormStyle.roundedInputDecoration(
        'Minuto',
        Icon(Icons.more_vert, color: kPrimaryColor, size: 26),
      ).copyWith(errorStyle: TextStyle(fontSize: 17)),
      autofocus: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fullField;
  }
}
