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

class _ScanButtonState extends ConsumerState<ScanButton> {
  MobileScannerController? _controller;
  StreamSubscription<BarcodeCapture>? _subscription;

  void _startScan() async {
    _controller = MobileScannerController();
    _subscription = _controller!.barcodes.listen(_handleBarcode);
    await _controller!.start();

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Escanear código QR'),
          ),
          body: MobileScanner(
            controller: _controller!,
          ),
        );
      },
    );

    // Limpiar después de cerrar el modal
    _subscription?.cancel();
    _controller?.dispose();
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
  void dispose() {
    _subscription?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _startScan,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
