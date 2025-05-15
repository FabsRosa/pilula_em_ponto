import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pilula_em_ponto/models/medicine.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/widgets/medicine_item.dart';

class MedicineList extends ConsumerWidget {
  const MedicineList({super.key});

  Widget _listContent(
    List<Medicine> activeMedicines,
    List<Medicine> inactiveMedicines,
  ) {
    int activeMedicinesTitle = activeMedicines.isNotEmpty ? 1 : 0;
    int inactiveMedicinesTitle = inactiveMedicines.isNotEmpty ? 1 : 0;
    return ListView.builder(
      itemCount:
          activeMedicines.length +
          activeMedicinesTitle +
          inactiveMedicines.length +
          inactiveMedicinesTitle +
          1, // For the SizedBox
      itemBuilder: (context, index) {
        if (activeMedicines.isNotEmpty &&
            index < (activeMedicines.length + activeMedicinesTitle)) {
          if (index == 0) {
            return _alarmTitle('Alarmes ativados');
          } else {
            int currentIndex = index - activeMedicinesTitle;
            return MedicineItem(
              key: ValueKey(activeMedicines[currentIndex].id),
              medicine: activeMedicines[currentIndex],
              index: currentIndex,
            );
          }
        } else if (inactiveMedicines.isNotEmpty &&
            index <
                (activeMedicines.length +
                    activeMedicinesTitle +
                    inactiveMedicines.length +
                    inactiveMedicinesTitle)) {
          if (index - (activeMedicinesTitle + activeMedicines.length) == 0) {
            return _alarmTitle('Alarmes desativados');
          } else {
            int currentIndex =
                index -
                (activeMedicinesTitle +
                    activeMedicines.length +
                    inactiveMedicinesTitle);
            return MedicineItem(
              key: ValueKey(inactiveMedicines[currentIndex].id),
              medicine: inactiveMedicines[currentIndex],
              index: currentIndex,
              alpha: 0.6,
            );
          }
        }
        return const SizedBox(height: 100);
      },
    );
  }

  Widget _alarmTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 24.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(medicinesProvider);

    final sortedMedicines = List<Medicine>.from(medicines);
    if (sortedMedicines.isNotEmpty) {
      sortedMedicines.sort((a, b) {
        var list = a.nextAlarmDate ?? a.firstUseDate;
        return list.compareTo(b.nextAlarmDate ?? b.firstUseDate);
      });
    }

    if (sortedMedicines.isEmpty) {
      return Center(
        child: Text(
          'Adicione um medicamento.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    } else {
      List<Medicine> activeMedicines =
          sortedMedicines.where((medicine) => medicine.isActive).toList();
      List<Medicine> inactiveMedicines =
          sortedMedicines.where((medicine) => !medicine.isActive).toList();
      return _listContent(activeMedicines, inactiveMedicines);
    }
  }
}
