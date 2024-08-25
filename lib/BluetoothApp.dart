import 'package:app_robo_2024/widgets/ButtonBluetoothClick.dart';
import 'package:app_robo_2024/widgets/ButtonBluetoothPress.dart';
import 'package:app_robo_2024/widgets/SpeedRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class BluetoothApp extends StatefulWidget {
  @override
  _BluetoothAppState createState() => _BluetoothAppState();
}

class _BluetoothAppState extends State<BluetoothApp> {
  BluetoothConnection? connection;
  final String nameDevice = 'ROBOT_CNTT';
  bool successFulDevice = false;

  @override
  void dispose() {
    connection?.dispose(); // Hủy kết nối Bluetooth
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SpeedRadio(
                    onPressed: sendCommand,
                  )),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Color.fromARGB(255, 147, 147, 147),
                    ),
                    child: Text(
                      successFulDevice ? nameDevice : "CHƯA KẾT NỐI",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: !successFulDevice
                    ? ElevatedButton(
                        onPressed: () => connectToESP32(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 102, 102),
                            padding: const EdgeInsets.all(15)),
                        child: const Text("Kết nối"),
                      )
                    : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Buttonbluetoothpress(
                              keyValue: 'O',
                              title: "Quay trái",
                              onPressed: sendCommand),
                          const SizedBox(
                            width: 10,
                          ),
                          Buttonbluetoothpress(
                              keyValue: 'R',
                              title: "Quay phải",
                              onPressed: sendCommand),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Joystick(
                        listener: (details) {
                          double x = details.x;
                          double y = details.y;

                          if (x.abs() > 0.5) {
                            if (x > 0) {
                              sendCommand('P'); // Phải
                            } else {
                              sendCommand('A'); // Trái
                            }
                          } else if (y.abs() > 0.5) {
                            if (y > 0) {
                              sendCommand('L'); // Lùi lại
                            } else {
                              sendCommand('T'); // Tiến tới
                            }
                          } else {
                            sendCommand('S'); // Dừng lại nếu không di chuyển
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Buttonbluetoothpress(
                              keyValue: 'X',
                              title: "Nâng tay",
                              onPressed: sendCommand),
                          const SizedBox(
                            width: 10,
                          ),
                          Buttonbluetoothpress(
                              keyValue: 'Z',
                              title: "Hạ tay",
                              onPressed: sendCommand),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          BluetoothButtonClick(
                            keyValue: 'V',
                            title: 'Mở kẹp phải',
                            onPressed: sendCommand,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BluetoothButtonClick(
                            keyValue: 'B',
                            title: 'Đóng kẹp phải',
                            onPressed: sendCommand,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          BluetoothButtonClick(
                            keyValue: 'N',
                            title: 'Mở kẹp trái',
                            onPressed: sendCommand,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BluetoothButtonClick(
                            keyValue: 'M',
                            title: 'Đóng kẹp trái',
                            onPressed: sendCommand,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void connectToESP32() async {
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    BluetoothDevice? selectedDevice;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang kết nối'),
        backgroundColor: Color.fromARGB(255, 151, 151, 151),
      ),
    );

    // Kiểm tra xem có thiết bị nào tên là "ROBOT_CNTT" hay không
    for (BluetoothDevice device in devices) {
      if (device.name == nameDevice) {
        selectedDevice = device;
        break;
      }
    }

    if (selectedDevice != null) {
      BluetoothConnection.toAddress(selectedDevice.address).then((conn) {
        setState(() {
          connection = conn;
          successFulDevice = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã kết nối với ${selectedDevice?.name}'),
            backgroundColor: Colors.green,
          ),
        );
        print('Đã kết nối với ${selectedDevice?.name}');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Không thể kết nối, xảy ra ngoại lệ, đảm bảo đã bật Bluetooth và ROBOT_CNTT'),
            backgroundColor: Colors.red,
          ),
        );
        print('Không thể kết nối, xảy ra ngoại lệ');
        print(error);
        successFulDevice = false;
      });
    } else {
      setState(() {
        successFulDevice = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không tìm thấy thiết bị'),
          backgroundColor: Colors.red,
        ),
      );
      print('Không tìm thấy thiết bị');
    }
  }

  void sendCommand(String command) {
    print(command);
    connection?.output.add(Uint8List.fromList(command.codeUnits));
    connection?.output.allSent;
  }
}
