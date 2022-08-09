import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/providers/ui_providers.dart';

import 'pages/home_page.dart';
import 'pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //para saber que pagina mostrar
      providers: [
        ChangeNotifierProvider(
          create: (_) => new UiProvider()),
        ChangeNotifierProvider(
          create: (_) => new Scanlistprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes:{
          'home': ( _ ) => HomePage(),
          'mapa': ( _ ) => MapaPage()
        },
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          ),
          primaryColor: Colors.deepPurple
           
        ),
      ),
    );
  }
}