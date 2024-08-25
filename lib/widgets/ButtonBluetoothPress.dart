import 'dart:async';

import 'package:flutter/material.dart';

class Buttonbluetoothpress extends StatefulWidget {
  final String keyValue;
  final String title;
  final void Function(String) onPressed;

  Buttonbluetoothpress({
    required this.keyValue,
    required this.title,
    required this.onPressed,
  });

  @override
  State<Buttonbluetoothpress> createState() => _ButtonbluetoothpressState();
}

class _ButtonbluetoothpressState extends State<Buttonbluetoothpress> {
  Timer? _timer;

  void _startSending(String command) {
    _timer?.cancel();

    // Bắt đầu gửi lệnh liên tục
    _timer = Timer.periodic(const Duration(milliseconds: 130), (timer) {
      widget.onPressed(command);
    });
  }

  void _stopSending() {
    widget.onPressed('S');
    // Dừng gửi lệnh
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopSending(); // Dừng gửi lệnh
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        _startSending(widget.keyValue);
      },
      onLongPressEnd: (details) {
        _stopSending();
      },
      child: ElevatedButton(
        onPressed: () async {
          widget.onPressed(widget.keyValue);
          await Future.delayed(Duration(milliseconds: 140));
          widget.onPressed('S');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 33, 72, 243),
        ),
        child: Text(widget.title),
      ),
    );
  }
}
