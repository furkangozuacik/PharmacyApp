import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacy/views/barcode_screen/overlay.dart';
import 'package:pharmacy/views/barcode_screen/result_screen.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      controller.switchCamera();
    });
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });

                controller.toggleTorch();
              },
              icon: Icon(Icons.flash_on,
                  color: isFlashOn ? Colors.blue : Colors.grey)),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          "QR Scanner ",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be started automatically",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                ],
              ),
            )),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          String code = barcode.rawValue ?? "---";
                          isScanCompleted = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        closeScreen: closeScreen,
                                        code: code,
                                      )));
                        }
                      },
                    ),
                    const QRScannerOverlay(overlayColour: bgColor),
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Developed by ES",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
