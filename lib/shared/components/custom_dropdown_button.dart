import 'package:flutter/material.dart';
import 'package:mobile_producer/shared/enums/product_categories.dart';
import 'package:mobile_producer/theme/theme_colors.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final List<T> options;
  T? chosenValue;
  final String text;
  final Function(dynamic) onChanged;

  CustomDropdownButton(
      {super.key,
      required this.options,
      this.chosenValue,
      required this.text,
      required this.onChanged});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton> {
  late T? _chosenValue;

  @override
  void initState() {
    super.initState();
    _chosenValue = widget.chosenValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.primary3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<T>(
          borderRadius: BorderRadius.circular(6),
          underline: SizedBox(),
          value: _chosenValue,
          isExpanded: true,
          style: TextStyle(
              overflow: TextOverflow.ellipsis, color: ThemeColors.black),
          hint: Text(
            widget.text,
            overflow: TextOverflow.ellipsis,
          ),
          items: widget.options
              .map((e) => DropdownMenuItem<T>(
                    child: Text(e["text"].toString()),
                    value: e["value"],
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              _chosenValue = newValue;
            });
            widget.onChanged(newValue);
          },
        ),
      ),
    );
  }
}
