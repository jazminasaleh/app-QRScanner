import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class Scanlistprovider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';
//colocar los nuevos scans en la base de datos
//mostrarlos en el widget
  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    //inserta en la base de datos
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //asignar el id de la base de datos al modelo
    nuevoScan.id = id;
    //inserta el nuevoscan al lista de scans simpre y cuando el tipo sea el mismo
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      //para actualizar la pantalla
      notifyListeners();
    }
    return nuevoScan;
  }

//obtener el listado de todos los scans
  cargarScans() async {
    final scans = await DBProvider.db.getTodosLosScans();
    //reemplazar el nuevo listado
    this.scans = [...scans];
    notifyListeners();
  }

//obtener el listado de los scans por tipo
  cargraScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    //reemplazar el nuevo listado
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

//borra todos los scans de la base de datos
  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  borarScansPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    this.cargraScansPorTipo(this.tipoSeleccionado);
  }
}
