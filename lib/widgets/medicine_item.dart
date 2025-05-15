import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pilula_em_ponto/models/medicine.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

class MedicineItem extends ConsumerStatefulWidget {
  const MedicineItem({
    super.key,
    required this.medicine,
    required this.index,
    this.alpha = 1,
  });

  final Medicine medicine;
  final int index;
  final double alpha;

  @override
  ConsumerState<MedicineItem> createState() => _MedicineItemState();
}

class _MedicineItemState extends ConsumerState<MedicineItem> {
  void _toggleActiveStatus() {
    setState(() {
      ref
          .read(medicinesProvider.notifier)
          .updateMedicine(
            updatedMedicine: widget.medicine.copyWith(
              isActive: !widget.medicine.isActive,
            ),
            oldMedicineId: widget.medicine.id,
          );
    });
  }

  _onDeleteItem({required Medicine medicine}) {
    ref.read(medicinesProvider.notifier).removeMedicine(medicine);
  }

  String _getIntervalString(int frequency) {
    final totalMinutes = (24 * 60) ~/ frequency;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours horas e $minutes minutos';
    } else if (hours > 0) {
      return '$hours horas';
    } else {
      return '$minutes minutos';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.medicine.id),
      background: Container(
        decoration: BoxDecoration(color: kErrorColor.withValues(alpha: 0.7)),
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
        _onDeleteItem(medicine: widget.medicine);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: ListTile(
          leading: Column(
            children: [
              Text(
                widget.medicine.formattedTime(widget.medicine.nextAlarmTime!),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white.withValues(alpha: widget.alpha),
                ),
              ),
              Text(
                widget.medicine.formattedDate(widget.medicine.nextAlarmDate!),
                style: TextStyle(
                  fontSize: 14.1,
                  color: Colors.white.withValues(alpha: widget.alpha),
                ),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MedicineType.medicineTypes
                    .firstWhere(
                      (type) => type.id == widget.medicine.medicineType,
                    )
                    .icon,
                color: kPrimaryColorBrighter.withValues(alpha: widget.alpha),
                size: 28,
              ),
              const SizedBox(width: 6),
              Text(
                widget.medicine.name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white.withValues(alpha: widget.alpha),
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Text(
                'A cada ${_getIntervalString(widget.medicine.frequency)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: widget.alpha),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
              Text(
                widget.medicine.isContinuous
                    ? 'Uso contínuo'
                    : '${widget.medicine.daysOfUse.toString()} dias restantes',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: widget.alpha),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ],
          ),
          trailing: Switch(
            value: widget.medicine.isActive,
            onChanged: (value) => _toggleActiveStatus(),
            activeColor: kPrimaryColorBrighter.withValues(alpha: widget.alpha),
            inactiveTrackColor: const Color.fromARGB(50, 188, 255, 248),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
