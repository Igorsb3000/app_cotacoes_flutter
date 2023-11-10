import 'dart:io';

import 'package:app_cotacoes/card_bolsa_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'card_moeda_item.dart';
import 'card_moeda_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeMaterial(),
    );
  }
}

class HomeMaterial extends StatefulWidget {
  const HomeMaterial({super.key});

  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final int tamLimite = 15;
  late Future<Map<String, dynamic>> dadosCotacoes;

  @override
  void initState() {
    super.initState();
    dadosCotacoes = getDadosCotacoes();
  }

  void atualizarDados(){
    setState(() {
      dadosCotacoes = getDadosCotacoes();
    });
  }


  Future<Map<String, dynamic>> getDadosCotacoes() async {
    print("get dados");
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.hgbrasil.com/finance?key=e0cfb324'),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body);

      print(data);

      return data;
    } catch (e) {
      print('Entrou no catch');
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: dadosCotacoes,
          builder: (context, snapshot) {
            print('Verificando dados...');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            final data = snapshot.data!;
            final List stocksList = data['results']['stocks'].values.toList();
            List coinsList = data['results']['currencies'].values.toList();
            coinsList.removeAt(0); // removendo esse item da lista: "source": "BRL",

            print('Dados carregados com sucesso!');

            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Cotações Brasil',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      print('Atualizando dados....');
                      atualizarDados();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // main card
                    SizedBox(
                      width: double.infinity,
                      child: CardMoedaPrincipal(
                        nomeMoeda: limitarTamanhoDaString(coinsList[0]['name'], tamLimite),
                        valorAtual: coinsList[0]['buy'],
                        variacao: coinsList[0]['variation'],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Outras moedas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coinsList.length,
                        itemBuilder: (context, index) {
                          return CardMoedaItem(nomeMoeda: limitarTamanhoDaString(coinsList[index]['name'], tamLimite),
                              valorAtual: coinsList[index]['buy'],
                              variacao: coinsList[index]['variation']
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bolsa de Valores',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 290,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Número de colunas desejado
                              crossAxisSpacing: 1.0, // Espaçamento horizontal entre os itens
                              mainAxisSpacing: 1.0, // Espaçamento vertical entre os itens
                            ),
                            itemCount: stocksList.length, // Substitua com o tamanho da sua lista
                            shrinkWrap: true, // Ocupa apenas o espaço necessário na altura
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CardBolsaItem(
                                  nomeBolsa: limitarTamanhoDaString(
                                      stocksList[index]['name'], tamLimite),
                                  localizacao: limitarTamanhoDaString(
                                      stocksList[index]['location'], tamLimite),
                                  pontos: stocksList[index]['points']
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

String limitarTamanhoDaString(String input, int limite) {
  if (input.length > limite) {
    return input.substring(0, limite);
  } else {
    return input;
  }
}


// Outra implementação da seção Bolsa de Valores
/*
                    SizedBox(
                      height: 290,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Define o número de colunas (2 colunas neste caso).
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: stocksList.length,
                        itemBuilder: (context, index) {
                          return CardBolsaItem(
                            nomeBolsa: limitarTamanhoDaString(
                                stocksList[index]['name'], tamLimite),
                            localizacao: limitarTamanhoDaString(
                                stocksList[index]['location'], tamLimite),
                            pontos: stocksList[index]['points'],
                          );
                        },
                      ),
                    )*/