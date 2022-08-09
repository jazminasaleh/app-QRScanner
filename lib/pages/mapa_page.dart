import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        backgroundColor: Colors.deepPurple,
        ),
      body: Center(child: Text(scan.valor)),
    );
  }
}
