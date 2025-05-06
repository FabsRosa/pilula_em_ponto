import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pilula_em_ponto/data/models/medicine.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

class MedicineItem extends ConsumerWidget {
  const MedicineItem({super.key, required this.medicine, required this.index});

  final Medicine medicine;
  final int index;

  _onDeleteItem({required Medicine medicine, required WidgetRef ref}) {
    ref.read(medicinesProvider.notifier).removeMedicine(medicine);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(medicine.id),
      background: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.error),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.white),
            const Spacer(),
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
      onDismissed: (direction) {
        _onDeleteItem(medicine: medicine, ref: ref);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListTile(
          leading: Icon(Icons.medication, color: kPrimaryColor, size: 28),
          title: Text(medicine.name, style: TextStyle(fontSize: 24)),
          subtitle: Text(
            'A cada ${medicine.dose.interval.toString()} horas',
            style: TextStyle(fontSize: 16),
          ),
          trailing: IconButton(
            onPressed: () {
              _onDeleteItem(medicine: medicine, ref: ref);
            },
            icon: Icon(
              Icons.delete,
              size: 28,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
