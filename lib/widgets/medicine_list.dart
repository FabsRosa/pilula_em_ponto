import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/widgets/medicine_item.dart';

class MedicineList extends ConsumerWidget {
  const MedicineList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(medicinesProvider);

    if (medicines.isEmpty) {
      return Center(
        child: Text(
          'Adicione um medicamento.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: medicines.length,
        itemBuilder:
            (context, index) => MedicineItem(
              key: ValueKey(medicines[index].id),
              medicine: medicines[index],
              index: index,
            ),
      );
    }
  }
}
