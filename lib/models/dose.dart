import 'package:pilula_em_ponto/models/medicine_type.dart';

class Dose {
  const Dose({
    required this.amount,
    required this.medicineType,
    required this.interval,
  });

  final int amount;
  final MedicineTypeId medicineType;
  final int interval;
}
