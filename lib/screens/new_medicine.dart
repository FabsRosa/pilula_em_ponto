import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pilula_em_ponto/data/models/dose.dart';

import 'package:pilula_em_ponto/data/models/medicine.dart';
import 'package:pilula_em_ponto/data/models/medicine_type.dart';
import 'package:pilula_em_ponto/providers/medicine_provider.dart';

class NewMedicineScreen extends ConsumerStatefulWidget {
  const NewMedicineScreen({super.key});

  @override
  ConsumerState<NewMedicineScreen> createState() => _NewMedicineScreenState();
}

class _NewMedicineScreenState extends ConsumerState<NewMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _amount = '';
  late MedicineTypeId medicineTypeId;
  var _interval = '';

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

  Widget get _nameTextField {
    return TextFormField(
      maxLength: 50,
      style: TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        label: Text('Nome do medicamento', style: TextStyle(fontSize: 18)),
        prefixIcon: Icon(Icons.medication),
      ),
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length > 50) {
          return 'Por favor, insira o nome do remédio.';
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
        label: Text('Qual a dose?', style: TextStyle(fontSize: 18)),
      ),
      style: TextStyle(fontSize: 20),
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira a dose do remédio.';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Por favor, insira um valor numérico válido.';
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
        label: Text('Tipo', style: TextStyle(fontSize: 18)),
      ),
      items:
          medicineTypes.map((MedicineType type) {
            return DropdownMenuItem<MedicineType>(
              value: type,
              child: Text(type.label, style: const TextStyle(fontSize: 18)),
            );
          }).toList(),
      onChanged: (value) {
        // Handle dropdown value change if needed
      },
      validator: (value) {
        if (value == null) {
          return 'Por favor, selecione o tipo de medicamento.';
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
        label: Text('A cada quantas horas?', style: TextStyle(fontSize: 18)),
        prefixIcon: Icon(Icons.access_time),
      ),
      style: TextStyle(fontSize: 20),
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira a frequência do remédio.';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Por favor, insira um valor numérico válido.';
        }
        return null;
      },
      onSaved: (value) {
        _interval = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Medicine'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.check))],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
