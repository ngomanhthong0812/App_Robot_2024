import 'package:flutter/material.dart';

class SpeedRadio extends StatefulWidget {
  final void Function(String) onPressed;

  SpeedRadio({
    required this.onPressed,
  });

  @override
  State<SpeedRadio> createState() => _SpeedRadioState();
}

class _SpeedRadioState extends State<SpeedRadio> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 147, 147, 147),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                "Tốc độ",
                style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            RadioItems(0, '100'),
            RadioItems(1, '150'),
            RadioItems(2, '200'),
            RadioItems(3, '250'),
          ],
        ),
      ),
    );
  }

  Column RadioItems(int value, String label) {
    return Column(
      children: [
        Radio<int>(
          value: value,
          groupValue: selectedIndex,
          onChanged: (int? newValue) {
            setState(() {
              selectedIndex = newValue!;
            });
            widget.onPressed(newValue.toString());
          },
        ),
        Text(label),
      ],
    );
  }
}
