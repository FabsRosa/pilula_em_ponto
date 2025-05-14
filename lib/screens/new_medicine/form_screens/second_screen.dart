import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/medicine_type.dart';
import 'package:pilula_em_ponto/screens/new_medicine/form_screens/fourth_screen.dart';
import 'package:pilula_em_ponto/screens/new_medicine/form_screens/third_screen.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/type_field.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_data.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({
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
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isValidating = false;

  void updateMedicineType(MedicineType medicineType) {
    widget.formData.medicineType = medicineType;
  }

  bool validator() {
    setState(() {
      isValidating = true;
      widget.validateForm();
    });
    return widget.formData.medicineType != null;
  }

  Widget get _nextScreen {
    if (widget.formData.medicineType == null ||
        widget.formData.medicineType!.id == MedicineTypeId.notInformed) {
      return FourthScreen(
        saveForm: widget.saveForm,
        validateForm: widget.validateForm,
        formData: widget.formData,
        formKey: widget.formKey,
      );
    } else {
      return ThirdScreen(
        saveForm: widget.saveForm,
        validateForm: widget.validateForm,
        formData: widget.formData,
        formKey: widget.formKey,
      );
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
                'assets/images/purple_medicine_type.png',
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Qual o tipo de medicamento?',
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            MedicineTypeField(
              updateMedicineType: updateMedicineType,
              medicineType: widget.formData.medicineType,
              isValidating: isValidating,
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
      body: Stack(
        children: [
          _formContent,
          NewMedicineFormStyle.nextButton(
            context: context,
            nextScreen: () => _nextScreen,
            validateForm: validator,
          ),
        ],
      ),
    );
  }
}
