import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLastLng(), zoom: 17, tilt: 50);
    //marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLastLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scan.getLastLng(), zoom: 17.5, tilt: 50)));
              },
              icon: Icon(Icons.location_on))
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.hybrid;
          }else{
             mapType = MapType.normal;
          }
          setState(() {
            
          });
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}
