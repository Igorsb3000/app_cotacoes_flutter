import 'package:flutter/material.dart';

class CardMoedaItem extends StatelessWidget {
  final String nomeMoeda;
  final double valorAtual;
  final double variacao;

  const CardMoedaItem({
    super.key,
    required this.nomeMoeda,
    required this.valorAtual,
    required this.variacao
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        height: 130,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              nomeMoeda,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              valorAtual.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(variacao.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}