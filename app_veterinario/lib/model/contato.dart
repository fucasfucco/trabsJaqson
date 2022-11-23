class Contato {
  String? id;
  String? nome;
  String? email;
  String? telefone;

  Contato() {
    id = null;
    nome = "";
    email = "";
    telefone = "";
  }

  Contato.init(this.id, this.nome, this.email, this.telefone);

  factory Contato.fromMap(Map<String, dynamic> json) {
    return Contato.init(
        json['_id'], json['nome'], json['email'], json['telefone']);
  }

  Map<String, dynamic> toMap() =>
      {'_id': id, 'nome': nome, 'email': email, 'telefone': telefone};

  @override
  toString() {
    return '$nome - $email';
  }

  bool operator ==(other) {
    return (other is Contato && other.id == id);
  }
}
