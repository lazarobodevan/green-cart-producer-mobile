import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_producer/shared/components/custom_text_field.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomDatePicker extends StatefulWidget {
  final String text;
  final Function(DateTime?) onChanged;
  DateTime? date;

  CustomDatePicker(
      {super.key, required this.text, required this.onChanged, this.date});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? _date;
  var _dateController = TextEditingController();
  DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _date = widget.date;
    if (_date != null) {
      _dateController.text = formatter.format(_date!);
    }
  }

  _selectDate(BuildContext context, DateTime? date) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());

    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        _dateController.text = formatter.format(date!);
      });
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _date = await _selectDate(context, _date);
        setState(() {});
        widget.onChanged(_date);
      },
      child: AbsorbPointer(
        child: SizedBox(
          child: CustomTextField(
            onChanged: (s) {},
            label: widget.text,
            controller: _dateController,
          ),
        ),
      ),
    );
  }
}
