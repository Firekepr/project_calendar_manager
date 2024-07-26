import 'package:flutter/material.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/styles/strings/app_strings.dart';
import 'package:project_calendar_manager/widget/buttons/simple_text_button.dart';
import 'package:project_calendar_manager/widget/input/simple_color_picker.dart';
import 'package:project_calendar_manager/widget/input/simple_date_picker.dart';
import 'package:project_calendar_manager/widget/input/simple_text_field.dart';
import 'package:project_calendar_manager/widget/page_header/page_header.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NewEventDialog extends StatefulWidget {
  const NewEventDialog({super.key});

  @override
  State<NewEventDialog> createState() => _NewEventDialogState();
}

class _NewEventDialogState extends State<NewEventDialog> {
  Color selectedColor = Colors.red;

  final _form = FormGroup({
    'description': FormControl<String>(value: null, validators: [Validators.required]),
    'date': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
    'color': FormControl<String>(value: '#ffffff', validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PageHeader(
              title: AppString.newEvent,
              titleColor: AppColors.black,
              iconColor: AppColors.black,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SimpleTextField(
                    formControlName: 'description',
                    label: AppString.description,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),

                  const SpinCareFormDatePicker(
                    formControlName: 'date',
                    label: AppString.eventDate,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12.0),
                  ),

                  SimpleColorPicker(
                    changeColor: changeColor,
                    selectedColor: selectedColor,
                    label: AppString.eventColor,
                  ),
                ],
              ),
            ),

            SimpleTextButton(
              label: 'Salvar',
              onPressed: () => {},
              widthByPercent: true,
              width: 0.40,
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) => setState(() => selectedColor = color);
}
