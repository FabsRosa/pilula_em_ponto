import 'package:pilula_em_ponto/models/medicine.dart';

class Medicines {
  static void updateAlarms(List<Medicine> medicines) {
    for (var medicine in medicines) {
      medicine.updateNextAlarm();
    }
  }
}
