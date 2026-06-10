import "package:sqflite/sqflite.dart" as sql;
import "heroi.dart";

class DataAccessObject {

  static Future<void> criarTabelas(sql.Database database) async {
    await database.execute("""
    CREATE TABLE herois (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nome TEXT NOT NULL,
      poder TEXT,
      rank TEXT,
      selecionado BOOLEAN
    );
    """);
    await database.execute("""
      INSERT INTO herois (nome, poder, rank, selecionado)
      VALUES ('Batman', 'Preparo e dinheiro', 'A', False);
    """);
    await database.execute("""
      INSERT INTO herois (nome, poder, rank, selecionado)
      VALUES ('Flash', 'Velocidade', 'S', False);
    """);
    await database.execute("""
      INSERT INTO herois (nome, poder, rank, selecionado)
      VALUES ('Homem-Aranha', 'Sentido aranha', 'B', False);
    """);
  }

  // Abre banco de dados, operações do CRUD
  static Future<sql.Database> abrirBanco() async {
    return await sql.openDatabase(
      "listadeherois.db",
      version: 1,
      onCreate: (db, version) async {
        await criarTabelas(db);
      },
    );
  }

  // C: Create
  static Future<int> incluirHerois(Heroi heroi) async {
    final banco = await DataAccessObject.abrirBanco();  
    final valores = {
      "nome": heroi.nome,
      "poder": heroi.poder,
      "rank": heroi.rank,
      "selecionado": heroi.selecionado,
    };
    final id = await banco.insert("herois", valores);
    return id;
  }

  // R: Read
  static Future<List<Heroi>> obterHerois() async {
    final banco = await DataAccessObject.abrirBanco();
    final maps = await banco.query("herois", orderBy: "nome");
    return maps.map((map) => Heroi.fromMap(map)).toList();
  }

  static Future<List<Heroi>> obterHeroisSelecionados() async {
    final banco = await DataAccessObject.abrirBanco();
    final maps = await banco.query("herois", where: "selecionado = ?", whereArgs: [1]);
    return maps.map((map) => Heroi.fromMap(map)).toList();
  }

  // U: Update
  static Future<int> alterarHeroi(Heroi heroi) async {
    final banco = await DataAccessObject.abrirBanco();
    final valores = { 
      "nome": heroi.nome, 
      "poder": heroi.poder, 
      "rank": heroi.rank,
      "selecionado": heroi.selecionado ? 1 : 0 
    };
    final resultado = await banco.update(
      "herois", 
      valores, 
      where: "id = ?", 
      whereArgs: [heroi.id],
    );
    return resultado;
  }

  // D: Delete
  static Future<bool> excluirHeroi(Heroi heroi) async {
    final banco = await DataAccessObject.abrirBanco();
    try {
      await banco.delete("herois", where: "id = ?", whereArgs: [heroi.id]);
      return true;
    } catch (erro) {
      print("Erro na exclusão: $erro");
      return false;
    }
  }
}