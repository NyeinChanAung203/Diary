import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    this.dateController,
    this.selectedDate,
  }) : super(key: key);

  final TextEditingController? dateController;
  final DateTime? selectedDate;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  ValueNotifier<String> hintText =
      ValueNotifier(DateFormat.yMd().format(DateTime(2000)));

  // String hintText = DateFormat.yMd().format(DateTime(2000));

  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime(2000));

  // DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    if (widget.selectedDate != null) {
      selectedDate.value = widget.selectedDate!;
    }
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1920),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
              ),
            ),
            child: child!,
          );
        });

    if (selected != null && selected != selectedDate.value) {
      selectedDate.value = selected;
      hintText.value = DateFormat.yMd().format(selected);
      widget.dateController!.text = DateFormat.yMd().format(selectedDate.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hintText,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: TextField(
            enabled: false,
            controller: widget.dateController,
            decoration: InputDecoration(
                hintText: hintText.value,
                hintStyle: const TextStyle(color: inputTextColor),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
        );
      },
    );
  }
}
