import 'package:flutter/material.dart';

class CardMoedaPrincipal extends StatelessWidget {
  final String nomeMoeda;
  final double valorAtual;
  final double variacao;

  const CardMoedaPrincipal({
    super.key,
    required this.nomeMoeda,
    required this.valorAtual,
    required this.variacao
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              nomeMoeda,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              valorAtual.toString(),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              variacao.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}