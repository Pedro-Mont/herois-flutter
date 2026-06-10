class Heroi {
  int? id;
  String nome;
  String poder;
  String rank;
  bool selecionado = false;

  Heroi({
    this.id, 
    required this.nome, 
    required this.poder, 
    required this.rank,
    this.selecionado = false,
  });

  factory Heroi.fromMap(Map<String, dynamic> map) {
    return Heroi(
      id: map["id"],
      nome: map["nome"],
      poder: map["poder"],
      rank: map["rank"],
      selecionado: map["selecionado"] == 1 ? true : false, 
    );
  }
}