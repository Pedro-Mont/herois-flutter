import 'package:flutter/material.dart';
import 'heroi.dart';

class HeroiCard extends StatelessWidget {
  final Heroi heroi;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback onDetails;

  const HeroiCard({
    super.key,
    required this.heroi,
    required this.onDelete,
    required this.onTap,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        heroi.selecionado ? Icons.check_box : Icons.check_box_outline_blank,
      ),
      title: Text(
        heroi.nome,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "Poder: ${heroi.poder} | Rank: ${heroi.rank}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Wrap(
        spacing: 8,
        children: [
          IconButton(
            onPressed: onDetails,
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}