import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_data.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/days_of_use_field.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/is_limited_field.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({
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
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  bool _isFieldEmpty = false;

  bool validator() {
    var isFieldEmpty =
        widget.formData.daysOfUseController.text.isEmpty ||
        int.parse(widget.formData.daysOfUseController.text) <= 0;
    widget.validateForm();
    setState(() {
      _isFieldEmpty = isFieldEmpty;
    });
    return !widget.formData.isLimitedTime || !isFieldEmpty;
  }

  void updateIsLimitedTime(bool isLimitedTime) {
    setState(() {
      widget.formData.isLimitedTime = isLimitedTime;
    });
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
                'assets/images/green_medicine_time.png',
                height: 140,
                width: 140,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Será consumido por tempo limitado?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              softWrap: true,
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            IsLimitedField(
              isLimitedTime: widget.formData.isLimitedTime,
              updateIsLimitedTime: updateIsLimitedTime,
            ),
            const SizedBox(height: 48),
            if (widget.formData.isLimitedTime)
              Text(
                'Por quantos dias?',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: TextStyle(
                  fontSize: NewMedicineFormStyle.fontSize,
                  color: Colors.white,
                ),
              ),
            if (widget.formData.isLimitedTime) const SizedBox(height: 24),
            if (widget.formData.isLimitedTime)
              DaysOfUseField(
                controller: widget.formData.daysOfUseController,
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
              NewMedicineFormStyle.finishButton(
                saveForm: widget.saveForm,
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
