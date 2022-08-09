import 'package:flutter/material.dart';

//Gestor de estado: provider
class UiProvider extends ChangeNotifier {
  int _selectedmenuOpt = 0;

  int get selectedmenuOpt {
    return this._selectedmenuOpt;
  }

//cambia selectd menu opt
  set selectedmenuOpt(int i) {
    this._selectedmenuOpt = i;
    //cambiar de widget
    notifyListeners();
  }
}
