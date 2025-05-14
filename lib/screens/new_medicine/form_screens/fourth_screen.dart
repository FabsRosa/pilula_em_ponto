import 'package:flutter/material.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_data.dart';
import 'package:pilula_em_ponto/models/new_medicine/new_medicine_form_style.dart';
import 'package:pilula_em_ponto/screens/new_medicine/form_screens/fifth_screen.dart';
import 'package:pilula_em_ponto/themes/main_colors.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/frequency_field.dart';
import 'package:pilula_em_ponto/widgets/new_medicine/fields/hour_field.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({
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
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  bool _isHourFieldEmpty = false;
  bool _isMinuteFieldEmpty = false;
  bool _isFrequencyFieldEmpty = false;

  bool validator() {
    var isHourFieldEmpty = widget.formData.hourController.text.isEmpty;
    var isMinuteFieldEmpty = widget.formData.hourController.text.isEmpty;
    var isFrequencyFieldEmpty =
        widget.formData.frequencyController.text.isEmpty ||
        int.parse(widget.formData.frequencyController.text) <= 0;
    widget.validateForm();
    setState(() {
      _isHourFieldEmpty = isHourFieldEmpty;
      _isMinuteFieldEmpty = isMinuteFieldEmpty;
      _isFrequencyFieldEmpty = isFrequencyFieldEmpty;
    });
    return !_isHourFieldEmpty &&
        !_isMinuteFieldEmpty &&
        !_isFrequencyFieldEmpty;
  }

  Widget get _formContent {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              'Qual o horário do próximo consumo?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              softWrap: true,
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            HourField(
              hourController: widget.formData.hourController,
              minuteController: widget.formData.minuteController,
              isHourFieldEmpty: _isHourFieldEmpty,
              isMinuteFieldEmpty: _isMinuteFieldEmpty,
            ),
            const SizedBox(height: 48),
            Text(
              'E quantas vezes ao dia?',
              style: TextStyle(
                fontSize: NewMedicineFormStyle.fontSize,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            FrequencyField(
              controller: widget.formData.frequencyController,
              isFieldEmpty: _isFrequencyFieldEmpty,
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
                color: kPrimaryColor,
                nextScreen:
                    () => FifthScreen(
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
