import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

class NewMedicineFormStyle {
  static const fontSize = 21.0;
  static const iconSize = 36.0;

  static InputDecoration roundedInputDecoration(String label, Icon? icon) {
    return InputDecoration(
      label: Text(
        label,
        style: const TextStyle(fontSize: fontSize, color: Colors.white),
      ),
      icon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimaryColor),
      ),
    );
  }

  static Widget finishButton({
    required void Function() saveForm,
    required bool Function() validateForm,
    Color color = kPrimaryColor,
  }) {
    return Positioned(
      bottom: 45,
      right: 30,
      child: FloatingActionButton.extended(
        backgroundColor: color,
        foregroundColor: kOnContainer,
        onPressed: () {
          if (validateForm()) {
            saveForm();
          }
        },
        icon: const Icon(Icons.check, size: 30),
        label: const Text(
          'Salvar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  static Widget nextButton({
    required BuildContext context,
    required Widget Function() nextScreen,
    required bool Function() validateForm,
    Color color = kSecondaryColor,
  }) {
    return Positioned(
      bottom: 45,
      right: 30,
      child: FloatingActionButton.extended(
        backgroundColor: color,
        foregroundColor: kOnContainer,
        onPressed: () {
          if (validateForm()) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => nextScreen()));
          }
        },
        icon: const Icon(Icons.arrow_forward, size: 30),
        label: const Text(
          'Próximo',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  static Widget nextButtonNotPositioned({
    required BuildContext context,
    required Widget Function() nextScreen,
    required bool Function() validateForm,
    Color color = kSecondaryColor,
  }) {
    return FloatingActionButton.extended(
      backgroundColor: color,
      foregroundColor: kOnContainer,
      onPressed: () {
        if (validateForm()) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => nextScreen()));
        }
      },
      icon: const Icon(Icons.arrow_forward, size: 30),
      label: const Text(
        'Próximo',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
