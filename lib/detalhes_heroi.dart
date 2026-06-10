import 'package:flutter/material.dart';
import 'heroi.dart';

class DetalhesHeroi extends StatelessWidget {
  final Heroi heroi;

  const DetalhesHeroi({super.key, required this.heroi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes: ${heroi.nome}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Codinome: ${heroi.nome}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Habilidade / Poder:",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Text(
              heroi.poder,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              "Classificação de Rank:",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Text(
              "Rank ${heroi.rank}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}