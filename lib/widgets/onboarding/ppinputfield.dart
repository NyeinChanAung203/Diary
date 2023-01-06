import 'package:diary/widgets/onboarding/datepicker.dart';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class PpInputField extends StatelessWidget {
  const PpInputField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.isTextField,
    required this.isDateField,
    required this.isGenderField,
    this.nameController,
    this.genderController,
    this.dateController,
    this.selectedDate,
  }) : super(key: key);

  final String title;
  final String hintText;
  final bool isTextField, isDateField, isGenderField;
  final TextEditingController? nameController, genderController, dateController;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'value': 'male',
        'label': 'Male',
      },
      {
        'value': 'female',
        'label': 'Female',
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.45),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: isTextField
                  ? TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    )
                  : isDateField
                      ? DatePicker(
                          dateController: dateController,
                          selectedDate: selectedDate,
                        )
                      : isGenderField
                          ? SelectFormField(
                              controller: genderController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              // initialValue: 'Select your gender',
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                border: InputBorder.none,
                                hintText: hintText,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              items: items,
                              // onChanged: (val) => debugPrint(val),
                              // onSaved: (val) => debugPrint(val),
                            )
                          : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
