import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanlListProvider = Provider.of<Scanlistprovider>(context);
    final scans = scanlListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) =>
          // es para poder borrar elementos desde la pantalla
          Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.purple[800]),
        onDismissed: (DismissDirection direction) {
          Provider.of<Scanlistprovider>(context, listen: false).
          borarScansPorId(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http'
             ? Icons.home_outlined
             : Icons.map_outlined,
            color: Colors.purple[600],
          ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => launchURL(context, scans[i]),
        ),
      ),
    );
  }
}
