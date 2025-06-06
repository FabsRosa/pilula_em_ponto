import 'package:flutter/material.dart';

enum MedicineTypeId { pills, drops, syrup, injection, capsule, notInformed }

class MedicineType {
  const MedicineType({
    required this.id,
    required this.label,
    required this.icon,
  });

  final MedicineTypeId id;
  final String label;
  final IconData icon;

  String get lowercaseLabel => label.toLowerCase();

  static const List<MedicineType> medicineTypes = [
    MedicineType(
      id: MedicineTypeId.pills,
      label: 'Comprimidos',
      icon: Icons.medication,
    ),
    MedicineType(
      id: MedicineTypeId.capsule,
      label: 'Cápsulas',
      icon: Icons.all_inclusive,
    ),
    MedicineType(
      id: MedicineTypeId.drops,
      label: 'Gotas',
      icon: Icons.water_drop,
    ),
    MedicineType(
      id: MedicineTypeId.syrup,
      label: 'Xarope',
      icon: Icons.local_drink,
    ),
    MedicineType(
      id: MedicineTypeId.injection,
      label: 'Injeções',
      icon: Icons.show_chart,
    ),
    MedicineType(
      id: MedicineTypeId.notInformed,
      label: 'Não informar',
      icon: Icons.block,
    ),
  ];
}
