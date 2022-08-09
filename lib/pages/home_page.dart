import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/direcciones_page.dart';
import 'package:qr_scanner/providers/db_provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/providers/ui_providers.dart';
import 'package:qr_scanner/widgets/custom_navigatorbar.dart';
import 'package:qr_scanner/widgets/scan_button.dart';

import 'mapas_pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              DBProvider.db.deleteAllScans();
              Provider.of<Scanlistprovider>(context, listen: false).borrarTodos();
            },
          )
        ],
      ),
      body: _HomePageBody(),
      //la parte de aabjo del home
      bottomNavigationBar: CutsomNavigatorBar(),
      //boton de scanner
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

//Se decine si se le da click al icono de mapa salga mapa
//y si se la de click a la direccion que salga direccion
class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener el selected menu opt, que lo busque en uiprovider
    final uiProvider = Provider.of<UiProvider>(context);
    //Esto es lo que cambia para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedmenuOpt;

    //leer la base de datos
    //DBProvider.db.database;
    //final tempScan = new ScanModel(valor: 'http://google.com');
    //crera nuevo registro en la base de datos
    //DBProvider.db.nuevoScan(tempScan);
    //BUscra algun regsutro en la base de datos
    //DBProvider.db.deleteAllScans().then(print);

    final scanlistprovider =
        Provider.of<Scanlistprovider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanlistprovider.cargraScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanlistprovider.cargraScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
