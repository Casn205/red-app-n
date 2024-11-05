import 'package:get/get.dart';
import '../models/bluetooth_device_model.dart';
import '../services/bluetooth_service.dart';

class BluetoothController extends GetxController {
  final BluetoothService _bluetoothService = BluetoothService();
  var devices = <BluetoothDevice>[].obs;
  var isScanning = false.obs;

  void startScan() async {
    isScanning.value = true;

    // Llama a la función startScan del servicio y maneja dispositivos encontrados
    await _bluetoothService.startScan((device) {
      if (!devices.any((d) => d.id == device.id)) {
        devices.add(device);
      }
    }).then((_) {
      isScanning.value = false;  // Finaliza el estado de escaneo si falla
    });
  }

  void stopScan() {
    isScanning.value = false;
    _bluetoothService.stopScan();
  }
}
