import 'package:get/get.dart';
import '../models/wifi_network.dart';
import '../services/wifi_service.dart';

class WifiController extends GetxController {
  var wifiNetworks = <WifiNetwork>[].obs;
  var isLoading = false.obs;  // Variable para manejar el estado de carga
  final WifiService _wifiService = WifiService();

  @override
  void onInit() {
    super.onInit();
    loadNetworks();
  }

  // Método para cargar redes Wi-Fi
  Future<void> loadNetworks() async {
    isLoading.value = true;
    try {
      List<WifiNetwork> networks = await _wifiService.getAvailableNetworks();
      wifiNetworks.value = networks;
    } catch (e) {
      print("Error al cargar redes Wi-Fi: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Método para refrescar la lista de redes
  Future<void> refreshNetworks() async {
    await loadNetworks();
  }
}
