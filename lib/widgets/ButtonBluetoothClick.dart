import 'package:flutter/material.dart';

class BluetoothButtonClick extends StatelessWidget {
  final String keyValue;
  final String title;
  final void Function(String) onPressed;

  BluetoothButtonClick({
    required this.keyValue,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      child: ElevatedButton(
        onPressed: () => onPressed(keyValue),
        child: Text(title),
      ),
    );
  }
}
