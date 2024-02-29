import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_producer/theme/theme_colors.dart';

class CustomSwitchButton extends StatefulWidget {
  bool value;
  final Function(bool) onChanged;

  CustomSwitchButton({super.key, required this.onChanged, this.value = false});

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: ThemeColors.primary3,
        value: _value,
        onChanged: (newValue) {
          setState(() {
            _value = newValue;
          });
          widget.onChanged(newValue);
        });
  }
}
