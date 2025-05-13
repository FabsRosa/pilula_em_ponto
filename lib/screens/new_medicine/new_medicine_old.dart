/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pilula_em_ponto/data/models/dose.dart';

import 'package:pilula_em_ponto/data/models/medicine.dart';
import 'package:pilula_em_ponto/data/models/medicine_type.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';

enum TimeOfUse {
  continuous('Uso Contínuo'),
  limitedTime('Período limitado');

  final String label;
  const TimeOfUse(this.label);
}

class NewMedicineScreen extends ConsumerStatefulWidget {
  const NewMedicineScreen({super.key});

  @override
  ConsumerState<NewMedicineScreen> createState() => _NewMedicineScreenState();
}

class _NewMedicineScreenState extends ConsumerState<NewMedicineScreen> {
  static const fontSize = 20.0;
  final _formKey = GlobalKey<FormState>();

  var _name = '';
  var _amount = '';
  var _interval = '';
  late MedicineTypeId medicineTypeId;
  late TimeOfUse timeOfUse;
  String? _startTime;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref
          .read(medicinesProvider.notifier)
          .addMedicine(
            Medicine(
              name: _name,
              dose: Dose(
                amount: int.parse(_amount),
                interval: int.parse(_interval),
                medicineType: medicineTypeId,
              ),
            ),
          );

      Navigator.of(context).pop();
    }
  }

  InputDecoration _roundedInputDecoration(String label, Icon? icon) {
    return InputDecoration(
      label: Text(
        label,
        style: const TextStyle(
          fontSize: _NewMedicineScreenState.fontSize,
          color: Colors.white,
        ),
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

  Widget get _nameTextField {
    return TextFormField(
      maxLength: 50,
      style: TextStyle(fontSize: 20),
      decoration: _roundedInputDecoration(
        'Nome do medicamento',
        Icon(Icons.medication, color: kPrimaryColor, size: 36),
      ),
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length > 50) {
          return 'Digite o nome do remédio.';
        }
        return null;
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget get _amountField {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text(
          'Qual a dose?',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
      style: TextStyle(fontSize: 20),
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite a dose do remédio.';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Digite um valor numérico válido.';
        }
        return null;
      },
      onSaved: (value) {
        _amount = value!;
      },
    );
  }

  Widget get _medicineTypeField {
    return DropdownButtonFormField<MedicineType>(
      decoration: const InputDecoration(
        label: Text(
          'Tipo',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
      isExpanded: true,
      items:
          medicineTypes.map((MedicineType type) {
            return DropdownMenuItem<MedicineType>(
              value: type,
              child: Text(
                type.label,
                style: const TextStyle(fontSize: fontSize, color: Colors.white),
              ),
            );
          }).toList(),
      onChanged: (value) {
        // Handle dropdown value change if needed
      },
      validator: (value) {
        if (value == null) {
          return 'Digite o tipo de medicamento.';
        }
        return null;
      },
      onSaved: (value) {
        medicineTypeId = value?.id ?? MedicineTypeId.pills;
      },
    );
  }

  Widget get _frequencyField {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text(
          'Quantas vezes por dia?',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
        icon: Icon(Icons.repeat, color: kSecondaryColor, size: 36),
      ),
      style: TextStyle(fontSize: 20),
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite a frequência do remédio.';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Digite um valor numérico válido.';
        }
        return null;
      },
      onSaved: (value) {
        _interval = value!;
      },
    );
  }

  Widget get _startHourField {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text(
          'Hora',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
        icon: Icon(Icons.access_time, color: kPrimaryColor, size: 36),
      ),
      style: TextStyle(fontSize: 20),
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite a hora.';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Digite um número.';
        }
        return null;
      },
      onSaved: (value) {
        _interval = value!;
      },
    );
  }

  Widget get _startMinuteField {
    return TextFormField(
      decoration: const InputDecoration(
        label: Text(
          'Minuto',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
        icon: Icon(Icons.unfold_more_rounded, color: kPrimaryColor, size: 16),
      ),
      style: TextStyle(fontSize: 20),
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Digite o minuto.';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Digite um número.';
        }
        return null;
      },
      onSaved: (value) {
        _interval = value!;
      },
    );
  }

  Widget get _startField {
    return Row(
      children: [
        Expanded(child: _startHourField),
        const SizedBox(width: 12),
        Expanded(child: _startMinuteField),
      ],
    );
  }

  Widget get _medicineForm {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/new_medicine.png',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 60),
              _nameTextField,
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: _amountField),
                  const SizedBox(width: 24),
                  Expanded(child: _medicineTypeField),
                ],
              ),
              const SizedBox(height: 54),
              _frequencyField,
              const SizedBox(height: 54),
              _startField,
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _addButton {
    return Positioned(
      bottom: 45,
      right: 30,
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: kOnContainer,
        onPressed: () => _saveForm,
        child: const Icon(Icons.check),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Remédio')),
      body: Stack(children: [_medicineForm, _addButton]),
    );
  }
}
 */
