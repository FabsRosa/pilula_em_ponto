import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_data.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';
import 'package:pilula_em_ponto/screens/new_medicine/form_screens/fourth_screen.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/quantity_field.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({
    super.key,
    required this.saveForm,
    required this.validateForm,
    required this.formKey,
    required this.formData,
  });

  final void Function() saveForm;
  final bool Function() validateForm;
  final GlobalKey<FormState> formKey;
  final NewMedicineFormData formData;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool _isFieldEmpty = false;

  bool validator() {
    var isFieldEmpty =
        widget.formData.quantityController.text.isEmpty ||
        int.parse(widget.formData.quantityController.text) <= 0;
    widget.validateForm();
    setState(() {
      _isFieldEmpty = isFieldEmpty;
    });
    return !isFieldEmpty;
  }

  void updateMedicineType(MedicineType medicineType) {
    widget.formData.medicineType = medicineType;
  }

  String get quantityQuestionPrefix {
    if (widget.formData.medicineType!.id == MedicineTypeId.pills) {
      return 'Quantos';
    } else if (widget.formData.medicineType!.id == MedicineTypeId.syrup) {
      return 'Quantos ml de';
    } else {
      return 'Quantas';
    }
  }

  Widget get _formContent {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Hero(
              tag: 'Imagem',
              child: Image.asset(
                'assets/images/purple_medicine_plus.png',
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              '$quantityQuestionPrefix ${widget.formData.medicineType!.lowercaseLabel}?',
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            QuantityField(
              controller: widget.formData.quantityController,
              iconData: widget.formData.medicineType!.icon,
              isFieldEmpty: _isFieldEmpty,
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Novo Remédio',
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _formContent),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NewMedicineFormStyle.nextButtonNotPositioned(
                context: context,
                nextScreen:
                    () => FourthScreen(
                      saveForm: widget.saveForm,
                      validateForm: widget.validateForm,
                      formData: widget.formData,
                      formKey: widget.formKey,
                    ),
                validateForm: validator,
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 45),
        ],
      ),
    );
  }
}
