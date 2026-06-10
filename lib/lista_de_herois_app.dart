import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navegacao.dart';

class ListaDeHeroisApp extends StatelessWidget {
  const ListaDeHeroisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 80, 253),
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: Navegacao(),
    );
  }
}

