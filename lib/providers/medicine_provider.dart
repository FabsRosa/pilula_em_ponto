import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pilula_em_ponto/models/medicine.dart';

class MedicinesNotifier extends StateNotifier<List<Medicine>> {
  MedicinesNotifier() : super(const []);

  void addMedicine(Medicine medicine) {
    state = [medicine, ...state];
  }

  void removeMedicine(Medicine medicine) {
    state =
        state
            .where((stateMedicine) => stateMedicine.id != medicine.id)
            .toList();
  }

  void insertMedicine(Medicine medicine, int index) {
    final newState = List<Medicine>.from(state);
    newState.insert(index, medicine);
    state = newState;
  }

  void updateMedicine({
    required Medicine updatedMedicine,
    required String oldMedicineId,
  }) {
    state =
        state.map((medicine) {
          return medicine.id == oldMedicineId ? updatedMedicine : medicine;
        }).toList();
  }
}

final medicinesProvider =
    StateNotifierProvider<MedicinesNotifier, List<Medicine>>((ref) {
      return MedicinesNotifier();
    });
