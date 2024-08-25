import 'package:app_robo_2024/BluetoothApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Đặt hướng màn hình thành ngang khi khởi động
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  // Ẩn thanh trạng thái và thanh điều hướng
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 249, 249, 249),
            backgroundColor: Colors.blue, // Màu chữ của nút
            padding: const EdgeInsets.all(25), // Padding cho nút
            textStyle: const TextStyle(fontSize: 18), // Kích thước chữ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Giảm độ bo góc
            ),
          ),
        ),
      ),
      home: BluetoothApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
