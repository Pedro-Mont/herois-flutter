import 'package:flutter/material.dart';
import 'data_access_object.dart';
import 'heroi.dart';
import 'heroi_card.dart'; // Import do novo componente
import 'detalhes_heroi.dart'; // Import da tela de detalhes

class ListaDeHerois extends StatefulWidget {
  const ListaDeHerois({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListaDeHeroisState();
  }
}

class _ListaDeHeroisState extends State<ListaDeHerois> {
  List<Heroi> _herois = [];

  final _heroiController = TextEditingController();
  final _poderController = TextEditingController();
  final _rankController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista() async {
    final listaNoBanco = await DataAccessObject.obterHerois();
    setState(() {
      _herois = listaNoBanco;
    });
  }

  void _incluirHeroi(Heroi heroi) async {
    await DataAccessObject.incluirHerois(heroi);
    _atualizarLista();
  }

  void _excluirHeroi(Heroi heroi) async {
    await DataAccessObject.excluirHeroi(heroi);
    _atualizarLista();
  }

  void _alterarHeroi(Heroi heroi) async {
    await DataAccessObject.alterarHeroi(heroi);
    _atualizarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Heróis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _heroiController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Herói",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _poderController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Poder",
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: _rankController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Rank",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        onPressed: () {
                          if (_heroiController.text.isEmpty ||
                              _poderController.text.isEmpty ||
                              _rankController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Preencha o nome do herói, seu poder e seu rank!",
                                ),
                              ),
                            );
                            return;
                          }

                          String poder = _poderController.text.trim();

                          if (RegExp(r'[0-9]').hasMatch(poder)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "O poder não pode conter números!",
                                ),
                              ),
                            );
                            return;
                          }

                          String rank = _rankController.text.trim().toUpperCase();

                          if (!["S", "A", "B", "C", "D", "E"].contains(rank)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Rank inválido! Utilize apenas S, A, B, C, D ou E.",
                                ),
                              ),
                            );
                            return;
                          }

                          var novoHeroi = Heroi(
                            nome: _heroiController.text,
                            poder: poder,
                            rank: rank,
                          );

                          _incluirHeroi(novoHeroi);

                          _heroiController.clear();
                          _poderController.clear();
                          _rankController.clear();
                        },
                        child: const Text("Adicionar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _herois.length,
                itemBuilder: (context, index) {
                  final heroiAtual = _herois[index];

                  return HeroiCard(
                    heroi: heroiAtual,
                    onDelete: () {
                      _excluirHeroi(heroiAtual);
                    },
                    onTap: () {
                      heroiAtual.selecionado = !heroiAtual.selecionado;
                      _alterarHeroi(heroiAtual);
                    },
                    onDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesHeroi(heroi: heroiAtual),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}