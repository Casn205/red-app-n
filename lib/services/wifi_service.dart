import 'package:wifi_scan/wifi_scan.dart';
import '../models/wifi_network.dart';
import 'package:permission_handler/permission_handler.dart';

class WifiService {
  // Método para solicitar el permiso de ubicación
  Future<void> requestLocationPermission() async {
  var status = await Permission.location.request();
    if (!status.isGranted) {
      throw Exception("Permiso de ubicación denegado $status");
    }
  }

  // Método para obtener las redes Wi-Fi disponibles
  Future<List<WifiNetwork>> getAvailableNetworks() async {
    List<WifiNetwork> networks = [];

    try {
      // Solicitar el permiso de ubicación antes de escanear
      await requestLocationPermission();

      // Inicia el escaneo de redes Wi-Fi
      final result = await WiFiScan.instance.getScannedResults();
      if (result != null) {
        for (var wifi in result) {
          networks.add(
            WifiNetwork(
              ssid: wifi.ssid ?? 'Unknown SSID',
              bssid: wifi.bssid ?? 'Unknown BSSID',
              signalStrength: wifi.level ?? 0,
            ),
          );
        }
      }
    } catch (e) {
      throw Exception("Error al cargar redes Wi-Fi en services: $e");
    }

    return networks;
  }
}
