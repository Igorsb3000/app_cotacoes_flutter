import 'package:flutter/material.dart';

class CardBolsaItem extends StatelessWidget {
  final String nomeBolsa;
  final String localizacao;
  final double pontos;

  const CardBolsaItem({
    super.key,
    required this.nomeBolsa,
    required this.localizacao,
    required this.pontos,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(

        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              nomeBolsa,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              localizacao.toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
                pontos.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16
                ),
            ),
          ],
        ),
      ),
    );
  }
}