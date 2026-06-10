import 'package:flutter/material.dart';
import 'data_access_object.dart';
import 'heroi.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  void _removerDosSelecionados(Heroi heroi) async {
    heroi.selecionado = false;
    await DataAccessObject.alterarHeroi(heroi);
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro De Heróis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Heroi>>(
        future: DataAccessObject.obterHeroisSelecionados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum herói registado.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          final heroisSelecionados = snapshot.data!;

          return ListView.builder(
            itemCount: heroisSelecionados.length,
            itemBuilder: (context, index) {
              final heroi = heroisSelecionados[index];

              return ListTile(
                title: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "- ${heroi.nome} / [ Poder: ${heroi.poder} ] / ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "[ Rank: ${heroi.rank} ] ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _removerDosSelecionados(heroi);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}