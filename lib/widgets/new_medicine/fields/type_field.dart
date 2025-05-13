import 'package:flutter/material.dart';

import 'package:pilula_em_ponto/themes/main_colors.dart';
import 'package:pilula_em_ponto/data/models/medicine_type.dart';

class MedicineTypeField extends StatelessWidget {
  final String? initialValue;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const MedicineTypeField({
    super.key,
    this.initialValue,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<MedicineType>(
      builder: (FormFieldState<MedicineType> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildTypeOptions(state),

            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  List<Widget> _buildTypeOptions(FormFieldState<MedicineType> state) {
    return MedicineType.medicineTypes.map((type) {
      final isSelected = state.value == type;
      return InkWell(
        onTap: () => state.didChange(type),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: isSelected ? kPrimaryColor : Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    type.icon,
                    color: isSelected ? kPrimaryColor : kSecondaryColorBrighter,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    type.label,
                    style: TextStyle(
                      fontSize: 22,
                      color: isSelected ? kPrimaryColor : Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      );
    }).toList();
  }
}
