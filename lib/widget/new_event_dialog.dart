import 'package:flutter/material.dart';
import 'package:project_calendar_manager/service/calendar/calendar_service.dart';
import 'package:project_calendar_manager/styles/colors/app_colors.dart';
import 'package:project_calendar_manager/widget/buttons/simple_text_button.dart';
import 'package:project_calendar_manager/widget/input/simple_color_picker.dart';
import 'package:project_calendar_manager/widget/input/simple_date_picker.dart';
import 'package:project_calendar_manager/widget/input/simple_text_field.dart';
import 'package:project_calendar_manager/widget/page_header/page_header.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewEventDialog extends StatefulWidget {
  const NewEventDialog({super.key});

  @override
  State<NewEventDialog> createState() => _NewEventDialogState();
}

class _NewEventDialogState extends State<NewEventDialog> {
  final _service = CalendarS();
  Color selectedColor = Colors.red;

  final _form = FormGroup({
    'description': FormControl<String>(value: 'Novo evento', validators: [Validators.required]),
    'date': FormControl<DateTime>(value: DateTime.now(), validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PageHeader(
              title: AppLocalizations.of(context)!.newEvent,
              titleColor: AppColors.black,
              iconColor: AppColors.black,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SimpleTextField(
                    formControlName: 'description',
                    label: AppLocalizations.of(context)!.description,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),

                  SpinCareFormDatePicker(
                    formControlName: 'date',
                    label: AppLocalizations.of(context)!.eventDate,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12.0),
                  ),

                  SimpleColorPicker(
                    changeColor: changeColor,
                    selectedColor: selectedColor,
                    label: AppLocalizations.of(context)!.eventColor,
                  ),
                ],
              ),
            ),

            SimpleTextButton(
              label: AppLocalizations.of(context)!.save,
              onPressed: save,
              widthByPercent: true,
              width: 0.40,
              margin: const EdgeInsets.only(bottom: 8.0),
              isFormButton: true,
            ),
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) => setState(() => selectedColor = color);

  Future<void> save() async {
    final item = {
      'description': _form.controls['description']!.value,
      'date': _form.controls['date']!.value.toString().substring(0, 10),
      'color': selectedColor.value.toRadixString(16),
      'user_id': 1,
    };

    await _service.saveEvent(item, context);
  }
}
