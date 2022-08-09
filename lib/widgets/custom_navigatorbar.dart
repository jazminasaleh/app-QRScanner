import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_providers.dart';

//La parte de abajo del home
class CutsomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedmenuOpt;
    return BottomNavigationBar(
      //Aca cuando se da click 
      //Aca se esta mencionando al set y se le esta asignando la i
      //Como no es una funcion normal no se colocan los parentisis (i) sino = i
      onTap: (int i) => uiProvider.selectedmenuOpt = i,
        //saber cual es el elmento seleccionado
        currentIndex: currentIndex,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
              ),
              label: 'Mapa'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.compass_calibration,
              ),
              label: 'Direcciones'),
        ]);
  }
}
