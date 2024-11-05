import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wifi_controller.dart';

class WifiListView extends StatelessWidget {
  final WifiController wifiController = Get.put(WifiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Wi-Fi Networks"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              wifiController.refreshNetworks();  // Llama al método para recargar redes
            },
          ),
        ],
      ),
      body: Obx(() {
        if (wifiController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (wifiController.wifiNetworks.isEmpty) {
          return Center(child: Text("No Wi-Fi networks found."));
        }
        return ListView.builder(
          itemCount: wifiController.wifiNetworks.length,
          itemBuilder: (context, index) {
            final network = wifiController.wifiNetworks[index];
            return ListTile(
              title: Text(network.ssid),
              subtitle: Text("Signal strength: ${network.signalStrength}"),
            );
          },
        );
      }),
    );
  }
}
