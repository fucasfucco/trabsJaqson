class Pet {
  String? id;
  String? nome;
  String? raca;
  String? idade;

  Pet() {
    id = null;
    nome = "";
    raca = "";
    idade = "";
  }

  Pet.init(this.id, this.nome, this.raca, this.idade);

  factory Pet.fromMap(Map<String, dynamic> json) {
    return Pet.init(json['_id'], json['nome'], json['raca'], json['idade']);
  }

  Map<String, dynamic> toMap() =>
      {'_id': id, 'nome': nome, 'raca': raca, 'idade': idade};

  @override
  toString() {
    return '$nome - $raca';
  }

  bool operator ==(other) {
    return (other is Pet && other.id == id);
  }
}
