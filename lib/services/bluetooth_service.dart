import 'package:quick_blue/quick_blue.dart';
import '../models/bluetooth_device_model.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothService {
  // Función para solicitar permisos antes de iniciar el escaneo
  Future<bool> _requestPermissions() async {
    // Aquí solicita tanto los permisos de ubicación como los permisos de Bluetooth
    final status = await [  // Usa este permiso en lugar de `location`
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    // Verifica que todos los permisos estén concedidos
    return status.values.every((permission) => permission.isGranted);
  }

  // Inicia el escaneo después de obtener permisos
  Future<void> startScan(Function(BluetoothDevice) onDeviceFound) async {
    bool permissionsGranted = await _requestPermissions();

    if (!permissionsGranted) {
      print("Los permisos necesarios no fueron concedidos.");
      return;
    }

    // Escuchar resultados del escaneo
    QuickBlue.scanResultStream.listen((result) {
      final device = BluetoothDevice(id: result.deviceId, name: result.name ?? "Unknown");
      onDeviceFound(device);
    });

    // Comienza el escaneo
    QuickBlue.startScan();
  }

  void stopScan() {
    QuickBlue.stopScan();
  }
}
