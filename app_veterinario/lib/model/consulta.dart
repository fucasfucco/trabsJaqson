class Consulta {
  String? id;
  String? nomeDono;
  String? nomePet;
  String? email;
  String? telefone;
  String? tempoProxConsulta;
  String? valorConsulta;
  String? descricao;

  Consulta() {
    id = null;
    nomeDono = "";
    nomePet = "";
    email = "";
    telefone = "";
    tempoProxConsulta = "";
    valorConsulta = "";
    descricao = "";
  }

  Consulta.init(this.id, this.nomeDono, this.nomePet, this.email, this.telefone,
      this.tempoProxConsulta, this.valorConsulta, this.descricao);

  factory Consulta.fromMap(Map<String, dynamic> json) {
    return Consulta.init(
        json['_id'],
        json['nomeDono'],
        json['nomePet'],
        json['email'],
        json['telefone'],
        json['tempoProxConsulta'],
        json['valorConsulta'],
        json['descricao']);
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'nomeDono': nomeDono,
        'nomePet': nomePet,
        'email': email,
        'telefone': telefone,
        'tempoProxConsulta': tempoProxConsulta,
        'valorConsulta': valorConsulta,
        'descricao': descricao
      };

  @override
  toString() {
    return '$nomeDono - $email';
  }

  bool operator ==(other) {
    return (other is Consulta && other.id == id);
  }
}
