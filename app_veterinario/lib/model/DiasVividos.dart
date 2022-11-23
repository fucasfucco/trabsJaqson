class DiasVividos {
  late String _nome;
  late int _idade;

  DiasVividos() {
    _nome = '';
    _idade = 0;
  }
  DiasVividos.iniciarTudo(this._nome, this._idade);
  DiasVividos.iniciarNome(nome) {
    this._nome = nome;
    this._idade = 0;
  }

  int getDiasVividos() {
    return _idade * 365;
  }

  int get diasVividos2 => getDiasVividos();

  String getResultado() {
    return '$_nome você viveu +- ${this.getDiasVividos()} dias';
  }

  String get nome {
    return _nome;
  }

  set nome(String nome) {
    this._nome = nome;
  }

  int get idade {
    return _idade;
  }

  set idade(int idade) {
    this._idade = idade;
  }
}
