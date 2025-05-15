import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

class IsContinuousField extends StatelessWidget {
  const IsContinuousField({
    super.key,
    required this.isContinuous,
    required this.updateIsLimitedTime,
  });

  final bool isContinuous;
  final void Function(bool isLimitedField) updateIsLimitedTime;
  static const radius = 12.0;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<bool>(
      value: isContinuous,
      dropdownStyleData: _dropdownStyleData,
      buttonStyleData: _buttonStyleData,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: [
        DropdownMenuItem(
          value: true,
          child: Text(
            'Sim',
            style: TextStyle(fontSize: NewMedicineFormStyle.fontSize),
          ),
        ),
        DropdownMenuItem(
          value: false,
          child: Text(
            'Não',
            style: TextStyle(fontSize: NewMedicineFormStyle.fontSize),
          ),
        ),
      ],
      onChanged: (value) => updateIsLimitedTime(value!),
      decoration: _inputDecoration,
    );
  }

  DropdownStyleData get _dropdownStyleData {
    return DropdownStyleData(
      width: 250,
      maxHeight: 400,
      offset: Offset.fromDirection(0, 50),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 44, 44, 44),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  ButtonStyleData get _buttonStyleData {
    return ButtonStyleData(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return kSeedColorBrighter.withValues(alpha: .1);
        }
        return null;
      }),
      elevation: 0,
    );
  }

  InputDecoration get _inputDecoration => InputDecoration(
    labelText: 'Selecione',
    labelStyle: TextStyle(
      color: Colors.white,
      fontSize: NewMedicineFormStyle.fontSize,
    ),
    icon: const Icon(Icons.help_outline, size: NewMedicineFormStyle.iconSize),
    iconColor: kPrimaryColorBrighter,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: Colors.white, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(color: Colors.white),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: kErrorColor, width: 0.25),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: kErrorColor, width: 0.5),
    ),
  );
}
