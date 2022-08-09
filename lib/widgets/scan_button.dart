import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

//El boton de scanner que se encunetra en la parte de abajo
//y su repectiva funcionalidad
class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 5,
        child: Icon(
          Icons.filter_center_focus,
        ),
        onPressed: () async {
          //final barcodeScanRes = 'https://pub.dev/packages/url_launcher/install';
          final barcodeScanRes = 'geo:45.28009,-75.922405';
          if (barcodeScanRes == '-1') {
            return;
          }
          final scanListProvider =
              Provider.of<Scanlistprovider>(context, listen: false);
          //Se agrga un nuevo scan a la base de datos
          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
          //scanListProvider.nuevoScan('geo:15.33,15.66');
          launchURL(context, nuevoScan);
        });
  }
}
