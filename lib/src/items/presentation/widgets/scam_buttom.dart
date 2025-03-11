import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr/src/items/items.dart'; // Importa mobile_scanner

class ScanButton extends ConsumerStatefulWidget {
  const ScanButton({super.key});

  @override
  ConsumerState<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends ConsumerState<ScanButton>
    with WidgetsBindingObserver {
  // Controlador para la cámara
  final MobileScannerController controller = MobileScannerController();

  // Suscripción para escuchar los códigos QR escaneados
  StreamSubscription<BarcodeCapture>? _subscription;

  @override
  void initState() {
    super.initState();
    // Iniciar la escucha de cambios en el ciclo de vida de la app
    WidgetsBinding.instance.addObserver(this);

    // Iniciar la escucha de códigos QR
    _subscription = controller.barcodes.listen(_handleBarcode);

    // Iniciar el escáner
    controller.start();
  }

  @override
  void dispose() {
    // Detener la escucha de cambios en el ciclo de vida de la app
    WidgetsBinding.instance.removeObserver(this);

    // Cancelar la suscripción de códigos QR
    _subscription?.cancel();
    _subscription = null;

    // Detener y liberar el controlador de la cámara
    controller.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Si el controlador no tiene permisos de cámara, no hacer nada
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Reanudar la escucha de códigos QR cuando la app se reanuda
        _subscription = controller.barcodes.listen(_handleBarcode);
        controller.start();
      case AppLifecycleState.inactive:
        // Detener la escucha de códigos QR cuando la app está inactiva
        _subscription?.cancel();
        _subscription = null;
        controller.stop();
    }
  }

  void _handleBarcode(BarcodeCapture barcode) {
    final List<Barcode> barcodes = barcode.barcodes;
    if (barcodes.isNotEmpty) {
      final String qrData = barcodes.first.rawValue ?? '';
      if (qrData.isNotEmpty) {
        print("Código QR escaneado: $qrData");
        ref.read(itemsProvider.notifier).createItem(qrData);
        Navigator.of(context).pop(); // Cerrar la pantalla de escaneo
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Abrir la pantalla de escaneo de QR
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Escanear código QR'),
              ),
              body: MobileScanner(
                controller: controller,
              ),
            );
          },
        );
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
