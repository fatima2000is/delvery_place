import 'package:delverplace/src/controller/fonctions.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';

class ScannerCode2 extends StatefulWidget {
  const ScannerCode2({super.key});

  @override
  State<ScannerCode2> createState() => _ScannerCode2State();
}

class _ScannerCode2State extends State<ScannerCode2> {
  inzajController controllers = Get.find<inzajController>();
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  MobileScannerController cameraController = MobileScannerController();
  @override
  void dispose() {
    super.dispose();
    controllers.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanner'),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              // ignore: sort_child_properties_last
              child: MobileScanner(
                  controller: cameraController,
                  onDetect: (barcode, args) async {
                    final String code = barcode.rawValue!;
                    controllers.scanner2(code, context);
                  }),
              bottom: 0,
            ),
            Positioned(
              bottom: 60,
              child: _buttons(),
            )
          ],
        ));
  }

  Widget _buttons() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      );
}
