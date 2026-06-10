import 'package:flutter/material.dart';
import 'lista_de_herois.dart';
import 'registro.dart';
import 'info.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({super.key});

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _indiceAtual = 0;

  final List<Widget> _telas = [
    ListaDeHerois(),
    Registro(),
    Info(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: "Registro",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Info",
          ),
        ],
      ),
    );
  }
}