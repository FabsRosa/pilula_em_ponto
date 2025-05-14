import 'package:flutter/material.dart';

import 'package:pilula_em_ponto/themes/main_colors.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';

class MedicineTypeField extends StatefulWidget {
  final void Function(MedicineType medicineType) updateMedicineType;
  final MedicineType? medicineType;
  final bool isValidating;

  const MedicineTypeField({
    super.key,
    required this.updateMedicineType,
    required this.medicineType,
    required this.isValidating,
  });

  @override
  State<MedicineTypeField> createState() => _MedicineTypeFieldState();
}

class _MedicineTypeFieldState extends State<MedicineTypeField> {
  @override
  Widget build(BuildContext context) {
    return FormField<MedicineType>(
      builder: (FormFieldState<MedicineType> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      (widget.isValidating &&
                              widget.medicineType == null &&
                              state.value == null)
                          ? kErrorColor
                          : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: [..._buildTypeOptions(state)]),
            ),
            if (widget.isValidating &&
                widget.medicineType == null &&
                state.value == null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Selecione o tipo',
                  style: TextStyle(color: kErrorColor, fontSize: 18),
                ),
              ),
          ],
        );
      },
      validator: (value) {
        if (value == null) {
          return 'Selecione um tipo.';
        } else {
          return null;
        }
      },
    );
  }

  List<Widget> _buildTypeOptions(FormFieldState<MedicineType> state) {
    MedicineType? currentValue = state.value ?? widget.medicineType;
    return MedicineType.medicineTypes.map((type) {
      final isSelected = currentValue == type;
      return InkWell(
        onTap: () {
          setState(() {
            state.didChange(type);
            widget.updateMedicineType(type);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? kPrimaryColorBrighter : Colors.transparent,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              children: [
                const SizedBox(height: 2.5),
                Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected ? kPrimaryColorBrighter : Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      type.icon,
                      color:
                          isSelected
                              ? kPrimaryColorBrighter
                              : type.id == MedicineTypeId.notInformed
                              ? const Color.fromARGB(255, 255, 152, 152)
                              : kSecondaryColorBrighter,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        type.label,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 22,
                          color:
                              isSelected ? kPrimaryColorBrighter : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.5),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
