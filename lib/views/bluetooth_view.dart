import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bluetooth_controller.dart';

class BluetoothView extends StatelessWidget {
  final BluetoothController controller = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bluetooth Devices")),
      body: Column(
        children: [
          Obx(() => controller.isScanning.value
              ? ElevatedButton(
                  onPressed: controller.stopScan,
                  child: Text("Stop Scan"),
                )
              : ElevatedButton(
                  onPressed: controller.startScan,
                  child: Text("Start Scan"),
                )),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.devices.length,
                  itemBuilder: (context, index) {
                    final device = controller.devices[index];
                    return ListTile(
                      title: Text(device.name),
                      subtitle: Text(device.id),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
